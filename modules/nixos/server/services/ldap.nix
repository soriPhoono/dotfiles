{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.server.ldap;
in {
  options.server.ldap.enable = lib.mkEnableOption "Enable ldap server for user management";

  config = lib.mkIf cfg.enable {
    sops.secrets =
      lib.genAttrs
      [
        "server/ldap/admin_password"
      ]
      (_: {
        inherit (config.services.openldap) group;

        owner = config.services.openldap.user;
        mode = "0440";
      });

    services = {
      openldap = let
        olcSuffix = builtins.concatStringsSep "," (
          map (element: "dc=${element}")
          (lib.splitString "." config.core.networking.tailscale.tn_name)
        );

        groups_bucket = "ou=groups,${olcSuffix}";
        people_bucket = "ou=people,${olcSuffix}";

        usersCode = ''
          dn: ${people_bucket}
          objectClass: top
          objectClass: organizationalUnit
          ou: people
          description: All users on the server

          ${builtins.concatStringsSep "\n\n" (builtins.attrValues (lib.mapAttrs (name: user: let
              user_dn = "uid=${name},${people_bucket}";
            in ''
              dn: ${user_dn}
              objectClass: top
              objectClass: person
              objectClass: organizationalPerson
              objectClass: inetOrgPerson
              uid: ${name}
              cn: ${user.first_name}
              sn: ${user.last_name}
              mail: ${user.email}
              userPassword: ${user.password_hash}
              ${builtins.concatStringsSep
                "\n"
                (map
                  (member: "memberOf: cn=${member},${groups_bucket}")
                  user.groups)}
            '')
            config.server.users))}
        '';

        groupCode = ''
          dn: ${groups_bucket}
          objectClass: top
          objectClass: organizationalUnit
          ou: groups
          description: All roles users can belong to

          ${builtins.concatStringsSep "\n\n" (map (name: ''
              dn: cn=${name},${groups_bucket}
              objectClass: top
              objectClass: groupOfNames
              cn: ${name}
              ${builtins.concatStringsSep
                "\n"
                (map
                  (member: "member: uid=${member},${people_bucket}")
                  (builtins.attrNames
                    (lib.filterAttrs
                      (_: user: builtins.any (group: group == name) user.groups)
                      config.server.users)))}
            '')
            config.server.groups)}
        '';
      in {
        enable = true;

        urlList = [
          "ldap://localhost:389"
        ];

        declarativeContents = {
          ${olcSuffix} = ''
            dn: ${olcSuffix}
            objectClass: top
            objectClass: domain
            dc: xerus-augmented

            ${groupCode}

            ${usersCode}
          '';
        };

        settings = {
          attrs = {
            olcLogLevel = "conns config";
          };

          children = {
            "cn=schema".includes = [
              "${pkgs.openldap}/etc/schema/core.ldif"
              "${pkgs.openldap}/etc/schema/cosine.ldif"
              "${pkgs.openldap}/etc/schema/inetorgperson.ldif"
            ];

            "olcDatabase={1}mdb" = {
              attrs = {
                inherit olcSuffix;

                objectClass = ["olcDatabaseConfig" "olcMdbConfig"];

                olcDatabase = "{1}mdb";
                olcDbDirectory = "/var/lib/openldap/data";

                olcRootDN = "cn=admin,${olcSuffix}";
                olcRootPW.path = config.sops.secrets."server/ldap/admin_password".path;

                olcAccess = [
                  ''                    {0}to attrs=userPassword
                                                      by self write
                                                      by anonymous auth
                                                      by * none''

                  ''                    {1}to *
                                                      by * read''
                ];
              };

              children = {
                "olcOverlay={2}ppolicy".attrs = {
                  objectClass = ["olcOverlayConfig" "olcPPolicyConfig" "top"];
                  olcOverlay = "{2}ppolicy";
                  olcPPolicyHashCleartext = "TRUE";
                };

                "olcOverlay={3}memberof".attrs = {
                  objectClass = ["olcOverlayConfig" "olcMemberOf" "top"];
                  olcOverlay = "{3}memberof";
                  olcMemberOfRefInt = "TRUE";
                  olcMemberOfDangling = "ignore";
                  olcMemberOfGroupOC = "groupOfNames";
                  olcMemberOfMemberAD = "member";
                  olcMemberOfMemberOfAD = "memberOf";
                };

                "olcOverlay={4}refint".attrs = {
                  objectClass = ["olcOverlayConfig" "olcRefintConfig" "top"];
                  olcOverlay = "{4}refint";
                  olcRefintAttribute = "memberof member manager owner";
                };
              };
            };
          };
        };
      };
    };
  };
}

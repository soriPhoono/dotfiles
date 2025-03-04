{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.suites.users;
in {
  options.core.suites.users = {
    enable =
      lib.mkEnableOption "Enable user management"
      // {
        default = true;
      };

    users = let
      userType = lib.types.submodule {
        options = {
          name = lib.mkOption {
            type = lib.types.str;
            description = "User name to set for the user";
          };
          admin = lib.mkEnableOption "Enable admin for the user";
          groups = lib.mkOption {
            type = with lib.types; listOf str;
            description = "Additional groups to add to the user";

            default = [];
          };
          shell = lib.mkOption {
            type = lib.types.package;
            description = "The package to use as the user's shell";

            default = pkgs.fish;
          };
        };
      };
    in
      lib.mkOption {
        type = lib.types.listOf userType;
        description = "Users to configure for interaction";

        default = [
          {
            name = "soriphoono";
            admin = true;
            shell = pkgs.fish;
          }
        ];
      };
  };

  config = lib.mkIf cfg.enable {
    # NOTE: This was so hard and I love it

    sops.secrets =
      (lib.listToAttrs (map (user: {
          name = "${user.name}/password";
          value = {
            neededForUsers = true;
          };
        })
        cfg.users))
      // (lib.listToAttrs (
        map (user: {
          name = "${user.name}/age_key";

          value = {
            inherit (config.users.extraUsers."${user.name}") group;

            path = "/tmp/${user.name}.key";

            mode = "0440";
            owner = user.name;
          };
        })
        config.core.suites.users.users
      ));

    snowfallorg.users = lib.listToAttrs (map (user: {
        inherit (user) name;

        value = {
          inherit (user) admin;
        };
      })
      cfg.users);

    users = {
      mutableUsers = false;

      extraUsers = lib.listToAttrs (map (user: {
          inherit (user) name;

          value = {
            inherit (user) shell;

            hashedPasswordFile = config.sops.secrets."${user.name}/password".path;

            extraGroups = user.groups;
          };
        })
        cfg.users);
    };

    programs = {
      dconf.enable = true;

      fish.enable = lib.any (user: user.shell == pkgs.fish) cfg.users;
    };
  };
}

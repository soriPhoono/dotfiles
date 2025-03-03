{
  lib,
  config,
  ...
}: let
  cfg = config.core.boot.secrets;
in {
  options.core.boot.secrets.defaultSopsFile = lib.mkOption {
    type = lib.types.path;
    description = "The path to the vault file";
  };

  config = let
    hostKeys = [
      {
        path = "/persist/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  in
    lib.mkIf config.core.boot.enable {
      services = {
        openssh = {
          inherit hostKeys;
        };
      };

      sops = {
        inherit (cfg) defaultSopsFile;

        age = {
          sshKeyPaths = map (key: key.path) hostKeys;
        };

        secrets =
          (
            lib.genAttrs
            (map (user: "${user}/age_key") config.core.suites.users.users)
            (name: let
              username = lib.elemAt (lib.splitString "/" name) 0;
            in {
              path = "/tmp/${username}.key";

              mode = "0440";
              owner = username;
              group = "users";
            })
          )
          // (
            lib.genAttrs
            (map (user: "${user}/password") config.core.suites.users.users)
            (_: {
              neededForUsers = true;
            })
          );
      };

      core.boot.impermanence.files = [
        "/etc/ssh/ssh_host_ed25519_key"
      ];
    };
}

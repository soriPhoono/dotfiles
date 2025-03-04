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
          enable = true;

          inherit hostKeys;
        };
      };

      sops = {
        inherit (cfg) defaultSopsFile;

        age = {
          sshKeyPaths = map (key: key.path) hostKeys;
        };
      };

      core.boot.impermanence.files = [
        "/etc/ssh/ssh_host_ed25519_key"
      ];
    };
}

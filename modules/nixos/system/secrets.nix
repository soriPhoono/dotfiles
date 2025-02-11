{
  lib,
  config,
  ...
}: let
  cfg = config.system.secrets;
in {
  options.system.secrets = {
    enable = lib.mkEnableOption "Enable secrets management";

    defaultSopsFile = lib.mkOption {
      type = lib.types.path;
      description = "Default database for import secrets";

      default = ../../../secrets/global.yaml;
    };
  };

  config = let
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  in
    lib.mkIf cfg.enable {
      services.openssh.hostKeys = hostKeys;

      sops = {
        inherit (cfg) defaultSopsFile;

        age = {
          sshKeyPaths = map (key: key.path) hostKeys;
        };

        secrets =
          lib.genAttrs
          (map (user: "${user}/age_key") config.system.users)
          (name: let
            username = lib.elemAt (lib.splitString "/" name) 0;
          in {
            sopsFile = config.system.secrets.defaultSopsFile;

            path = "/tmp/${username}.key";

            mode = "0440";
            owner = username;
            group = "users";
          });
      };

      system.impermanence.files = map (key: key.path) hostKeys;
    };
}

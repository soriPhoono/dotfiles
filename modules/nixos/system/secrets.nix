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
    hostKeys = map (key: key.path) config.services.openssh.hostKeys;
  in
    lib.mkIf cfg.enable {
      sops = {
        inherit (cfg) defaultSopsFile;

        age = {
          sshKeyPaths = hostKeys;
        };

        secrets = let
          getName = token: lib.elemAt (lib.splitString "/" token) 0;
        in
          lib.genAttrs
          (map (user: "${user}/password") config.system.users)
          (_: {
            sopsFile = config.system.secrets.defaultSopsFile;

            neededForUsers = true;
          })
          // lib.genAttrs
          (map (user: "${user}/age_key") config.system.users)
          (name: let
            username = getName name;
          in {
            sopsFile = config.system.secrets.defaultSopsFile;

            path = "/tmp/${username}.key";

            mode = "0440";
            owner = username;
            group = "users";
          });
      };

      system.impermanence.files = hostKeys;
    };
}

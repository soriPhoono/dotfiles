{
  lib,
  config,
  ...
}: let
  cfg = config.core.secrets;
in {
  options.core.secrets = {
    defaultSopsFile = lib.mkOption {
      type = lib.types.path;
      description = "Default sops database";
    };

    environment = {
      enable = lib.mkEnableOption "Enable environment secrets";

      sopsFile = lib.mkOption {
        type = lib.types.path;
        description = "Sops file for environment secrets";
      };
    };
  };

  config = {
    sops = {
      inherit (cfg) defaultSopsFile;

      age = {
        keyFile = "/tmp/${config.home.username}.key";
        sshKeyPaths = [];
        generateKey = true;
      };

      secrets.environment = lib.mkIf cfg.environment.enable {
        format = "dotenv";
        inherit (cfg.environment) sopsFile;
      };
    };
  };
}

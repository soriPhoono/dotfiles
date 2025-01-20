{
  lib,
  config,
  ...
}: let
  cfg = config.core.secrets;
in {
  options.core.secrets = {
    enable = lib.mkEnableOption "Enable secrets management";

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

  config = lib.mkIf cfg.enable {
    sops = {
      inherit (cfg) defaultSopsFile;

      age = {
        keyFile = "${config.home.homeDirectory}/keys.txt";
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

{
  lib,
  config,
  nixosConfig,
  ...
}: let
  cfg = config.core.secrets;
in {
  options.core.secrets = {
    enable = lib.mkEnableOption "Enable core secrets management";

    defaultSopsFile = lib.mkOption {
      type = with lib.types; nullOr path;
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

      age.keyFile = nixosConfig.sops.secrets."users/${config.home.username}/age_key".path;

      secrets.environment = lib.mkIf cfg.environment.enable {
        format = "dotenv";

        inherit (cfg.environment) sopsFile;
      };
    };
  };
}

{ lib, config, ... }:
let cfg = config.desktop.greetd;
in {
  options = {
    desktop.greetd = {
      enable = lib.mkEnableOption "Enable greetd login system";

      command = lib.mkOption {
        type = with lib.types; str;
        description = "Greetd launch command";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;

      settings.default_session = { inherit (cfg) command; };
    };
  };
}

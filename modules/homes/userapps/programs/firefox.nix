{ lib, config, ... }:
let cfg = config.userapps.programs.firefox;
in {
  options = {
    userapps.programs.firefox = {
      enable = lib.mkEnableOption "Enable firefox";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
    };
  };
}

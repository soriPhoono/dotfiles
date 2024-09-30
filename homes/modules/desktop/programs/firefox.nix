{ lib, pkgs, config, ... }:
let cfg = config.desktop.programs.firefox;
in {
  options = {
    desktop.programs.firefox.enable =
      lib.mkEnableOption "Enable firefox browser";
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;

      package = pkgs.wrapFirefox
        (pkgs.firefox-unwrapped.override { pipewireSupport = true; })
        { };
    };
  };
}

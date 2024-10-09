{ lib, pkgs, config, ... }:
let cfg = config.userapps.office;
in {
  options = {
    userapps.office.enable = lib.mkEnableOption "Enable office programs";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # Office work
      onlyoffice-desktopeditors
      slack
    ];

    programs.firefox = {
      enable = true;

      package = pkgs.wrapFirefox
        (pkgs.firefox-unwrapped.override { pipewireSupport = true; }) { };
    };
  };
}

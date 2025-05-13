{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.plasma;
in {
  options.desktop.plasma = {
    enable = lib.mkEnableOption "Enable gnome desktop environment";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      elegant-sddm
    ];

    services = {
      displayManager = {
        defaultSession = "plasma";
        sddm = {
          enable = true;
          wayland = {
            enable = true;
            compositor = "kwin";
          };
          theme = "Elegant";
        };
      };
      desktopManager.plasma6.enable = true;
    };
  };
}

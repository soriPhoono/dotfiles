{ lib, pkgs, config, ... }:
let cfg = config.desktop.services.sddm;
in {
  options = {
    desktop.services.sddm = {
      enable = lib.mkEnableOption "Enable sddm display manager";

      useKWin = lib.mkEnableOption "Use kwin as sddm backend";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.catppuccin-sddm-corners
    ];

    services.displayManager = {
      sddm = {
        enable = true;

        wayland = {
          enable = true;
          compositor = if cfg.useKWin then "kwin" else "weston";
        };

        theme = "catppuccin-sddm-corners";
      };
    };
  };
}

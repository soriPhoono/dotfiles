{ lib, pkgs, config, ... }:
let cfg = config.hyprland;
in {
  options = {
    hyprland.enable = lib.mkEnableOption "Enable Hyprland Desktop";
  };

  config = {
    services = {
      /* displayManager.sddm = {
        enable = true;
        wayland = {
          enable = true;
          compositor = "weston";
        };

        extraPackages = with pkgs; [
          catppuccin-sddm-corners
        ];
        theme = "catppuccin-sddm-corners";
      }; */

      programs.hyprland.enable = true;
    };

    environment.systemPackages = with pkgs; [
      kitty
    ];
  };
}

{ inputs, lib, pkgs, config, system, ... }:
let cfg = config.hyprland;
in {
  options = {
    hyprland.enable = lib.mkEnableOption "Enable Hyprland Desktop";
  };

  config = {
    security.polkit.enable = true;

    desktop.managers = {
      pipewire.enable = true;
      sddm.enable = true;
    };

    environment.systemPackages = with pkgs; [
      catppuccin-sddm-corners
    ];

    programs = {
      hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${system}.hyprland;
      };

      hyprlock.enable = true;

      gnome-disks.enable = true;
    };

    services = {
      udisks2 = {
        enable = true;
        mountOnMedia = true;
      };

      displayManager.sddm = {
        wayland = {
          compositor = "weston";
        };

        theme = "catppuccin-sddm-corners";
      };

      hypridle.enable = true;
    };
  };
}

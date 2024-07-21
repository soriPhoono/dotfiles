{ inputs, lib, pkgs, config, system, ... }:
let cfg = config.hyprland;
in {
  options = {
    hyprland.enable = lib.mkEnableOption "Enable Hyprland Desktop";
  };

  config = {
    environment.systemPackages = with pkgs; [
      catppuccin-sddm-corners
    ];

    programs = {
      hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${system}.hyprland;
      };

      hyprlock.enable = true;
    };

    services = {
      pipewire = {
        enable = true;

        pulse.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        jack.enable = true;
      };

      displayManager.sddm = {
        enable = true;

        wayland = {
          enable = true;
          compositor = "weston";
        };

        theme = "catppuccin-sddm-corners";
      };

      hypridle.enable = true;
    };

    security.polkit.enable = true;

    users.users.soriphoono.extraGroups = [
      "audio"
    ];
  };
}

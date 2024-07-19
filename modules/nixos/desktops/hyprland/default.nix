{ inputs, lib, pkgs, config, system, ... }:
let cfg = config.hyprland;
in {
  options = {
    hyprland.enable = lib.mkEnableOption "Enable Hyprland Desktop";
  };

  config = {
    services = {
      displayManager.sddm = {
        enable = true;

        wayland = {
          enable = true;
          compositor = "weston";
        };

        theme = "catppuccin-sddm-corners";
      };

      pipewire = {
        enable = true;

        pulse.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        jack.enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      catppuccin-sddm-corners
    ];

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${system}.hyprland;
    };

    users.users.soriphoono.extraGroups = [
      "audio"
    ];
  };
}

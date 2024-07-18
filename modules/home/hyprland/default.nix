{ inputs, lib, pkgs, config, ... }:
let cfg = config.hyprland;
in {
  options = {
    hyprland.enable = lib.mkEnableOption "Enable personal hyprland configuration";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        "$mod" = "SUPER";

        bind = [
          "$mod, B, exec, firefox"
          "$mod, RETURN, exec, alacritty"
        ];
      };
    };

    alacritty = {
      enable = true;

      settings = {
        window = {
          opacity = config.home.hyprland.opacity;

          blur = true;

          decorations = "None";
          startup_mode = "Maximized";
        };

        cursor.style = "Beam";
      };
    };  };
}

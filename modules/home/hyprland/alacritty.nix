{ lib, pkgs, config, ... }:
let cfg = config.hyprland.alacritty;
in {
  options = {
    hyprland.alacritty.enable = lib.mkEnableOption "Enable Alacritty";
  };

  cfg.enable = lib.mkDefault config.hyprland.enable;

  config = lib.mkIf cfg.enable {
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
    };
  }
}

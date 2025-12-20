{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.environments.hyprland;
in with lib; {
  options.desktop.environments.hyprland = {
    enable = mkEnableOption "Enable hyprland desktop environment base.";
  };

  config = mkIf cfg.enable {
    desktop.programs = {
      sddm = mkIf (!config.programs.sddm.enable) {
        enable = true;
        theme = {
          package = (pkgs.catppuccin-sddm.override {
            flavor = "frappe";
            accent = "teal";
            background = "${lib.${namespace}.wallpaper "beach-path.jpg"}";
            loginBackground = true;
          });
          name = "catppuccin-frappe-teal";
        };
      };

      uwsm.enable = true;
    };

    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };
  };
}

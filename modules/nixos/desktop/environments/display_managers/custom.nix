{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.environments.display_managers;
in
  with lib; {
    config = mkIf (config.desktop.environment == null) {
      desktop.environments.display_managers.sddm = {
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
    };
  }

{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  cfg = config.desktop.environments.display_managers;
in
  with lib; {
    config = mkIf (config.desktop.environment == null) {
      desktop.environments.display_managers.sddm = {
        enable = true;
        theme = {
          package = (pkgs.catppuccin-sddm.override {
            flavor = "frappe";
            accent = "teal";
            background = builtins.trace lib ../../../../../assets/wallpapers/beach-path.jpg;
            loginBackground = true;
          });
          name = "catppuccin-frappe-teal";
        };
      };
    };
  }

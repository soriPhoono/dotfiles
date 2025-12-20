{
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.desktop.environments.display_managers.sddm;
in
  with lib; {
    options.desktop.environments.display_managers.sddm = {
      theme = {
        package = mkOption {
          type = with types; nullOr package;
          default = null;
          description = "The theme package to use";
          example = pkgs.catppuccin-sddm.override {
            flavor = "frappe";
            accent = "teal";
            background = "${lib.${namespace}.wallpaper "beach-path.jpg"}";
            loginBackground = true;
          };
        };

        name = mkOption {
          type = with types; nullOr str;
          default = null;
          description = "The theme name to use";
          example = "catppuccin-frappe-teal";
        };
      };
    };

    config = mkIf (config.desktop.environment == "kde") {
      environment.systemPackages = mkIf (cfg.theme.package != null) [
        cfg.theme.package
      ];

      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        theme = mkIf (cfg.theme.name != null) cfg.theme.name;
      };
    };
  }

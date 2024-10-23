{ lib, pkgs, config, ... }:
let cfg = config.desktop.services.sddm;
in {
  options = {
    desktop.services.sddm = {
      enable = lib.mkEnableOption "Enable sddm display manager";

      useKWin = lib.mkEnableOption "Use kwin as sddm backend";

      theme = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "Elegant";

          description = "Use theme name";
        };

        package = lib.mkPackageOption pkgs "theme" {
          default = pkgs.elegant-sddm;
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      cfg.theme.package
    ];

    services.displayManager = {
      sddm = {
        enable = true;

        wayland = {
          enable = true;
          compositor = if cfg.useKWin then "kwin" else "weston";
        };

        theme = cfg.theme.name;
      };
    };
  };
}

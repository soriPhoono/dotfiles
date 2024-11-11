{ lib, pkgs, config, ... }:
let cfg = config.desktop.services.sddm;
in {
  options = {
    desktop.services.sddm = {
      enable = lib.mkEnableOption "Enable sddm display manager";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      (pkgs.where-is-my-sddm-theme.override {
        themeConfig.General = {
          backgroundFill = "#1e1e2e";
          basicTextColor = "#cdd6f4";
          passwordCursorColor = "#cdd6f4";
          passwordInputBackground = "#1e1e2e";
          passwordTextColor = "#cdd6f4";
        };
      })
    ];

    services.displayManager = {
      sddm = {
        enable = true;

        wayland = {
          enable = true;

          compositor = "kwin";
        };

        theme = "where_is_my_sddm_theme";
      };
    };
  };
}

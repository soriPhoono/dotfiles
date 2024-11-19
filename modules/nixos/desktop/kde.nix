{ lib, pkgs, config, ... }:
let cfg = config.desktop.kde;
in {
  options = {
    desktop.kde.enable = lib.mkEnableOption "Enable kde desktop environment";
  };

  config = lib.mkIf cfg.enable {
    desktop.enable = true;

    environment.systemPackages = with pkgs; [
      (where-is-my-sddm-theme.override {
        themeConfig.General = {
          hideCursor = false;
          passwordInputWidth = 0.4;
          passwordInputRadius = 0.5;
          passwordFontSize = 36;
          passwordInputCursorVisible = false;
          passwordCharacter = "•";
          backgroundFill = "#1e1e2e";
          blurRadius = 10;
          basicTextColor = "#cdd6f4";
          passwordCursorColor = "#cdd6f4";
          passwordInputBackground = "#313244";
          passwordTextColor = "#cdd6f4";
          showUsersByDefault = true;
          usersFontSize = 24;
        };
      })
    ];

    services.displayManager.sddm = {
      enable = true;

      wayland.enable = true;

      theme = "where_is_my_sddm_theme";
    };

    services.desktopManager.plasma6.enable = true;
  };
}

{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.environments.cosmic;
in
  with lib; {
    options.desktop.environments.cosmic = {
      enable = mkEnableOption "Enable cosmic desktop";
    };

    config = mkIf cfg.enable {
      environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;

      programs.firefox.preferences = {
        # disable libadwaita theming for Firefox
        "widget.gtk.libadwaita-colors.enabled" = false;
      };

      services = {
        system76-scheduler.enable = true;
        displayManager.cosmic-greeter.enable = true;
        desktopManager.cosmic.enable = true;
      };
    };
  }

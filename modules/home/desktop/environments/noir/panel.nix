{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.environments.noir;
in {
  config = lib.mkIf cfg.enable {
    desktop.programs.hyprpanel = {
      theme = "catppuccin_frappe_vivid";

      layout = {
        "bar.layouts" = {
          "*" = {
            left = [
              "dashboard"
              "workspaces"
              "systray"
            ];
            middle = [];
            right = [
              "network"
              "bluetooth"
              "volume"
              "battery"
              "clock"
              "notifications"
            ];
          };
        };
      };

      settings = {
        bar = {
          launcher.autoDetectIcon = true;
          workspaces.show_icons = true;
        };

        menus = {
          clock = {
            time.hideSeconds = true;
          };
          dashboard = {
            stats.enable_gpu = true;
          };
        };

        theme = {
          font = {
            name = "AurulentSansM Nerd Font Propo";
            size = "1rem";
          };
          bar.menus.menu.dashboard.scaling = 75;
        };
      };
    };
  };
}

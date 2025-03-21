{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.environments.noir;
in {
  config = lib.mkIf cfg.enable {
    desktop.programs.hyprpanel = {
      layout = {
        "bar.layouts" = {
          "*" = {
            left = [
              "dashboard"
              "workspaces"
            ];
            middle = [];
            right = [
              "systray"
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
        theme.bar.menus.menu.dashboard.scaling = 75;
        theme.font.size = "1rem";
      };
    };
  };
}

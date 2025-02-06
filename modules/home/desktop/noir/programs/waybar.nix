{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;

      settings = {
        statusBar = {
          layer = "top";

          height = 20;

          margin-top = 20;
          margin-left = 20;
          margin-right = 20;

          modules-left = [
            "custom/session_controls"
            "hyprland/workspaces"
          ];

          modules-center = [
          ];

          modules-right = [
            "upower"
            "clock"
          ];

          "custom/session_controls" = {
            format = "";
            on-click = "wlogout";

            tooltip-format = "Session management";
          };

          "hyprland/workspaces" = {
            active-only = true;
            all-outputs = true;

            format = "{icon}";

            format-icons = {
              active = "󰑊";
              default = "󰑊";
              empty = "";
              urgent = "󰑊";

              "1" = "";
              "2" = "";
              "3" = "󰈹";
              "4" = "󰝚";
              "5" = "";
              "6" = "󰑋";
            };

            persistent-workspaces = {
              "*" = 6;
            };
          };

          upower = {
            format = " {percentage}";

            native-path = "BAT0";
            icon-size = 15;
            hide-if-empty = true;
          };
        };
      };

      style = ''

      '';

      systemd.enable = true;
    };
  };
}

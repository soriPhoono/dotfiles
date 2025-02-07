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
          name = "statusBar";

          layer = "top";

          height = 20;

          modules-left = [
            "custom/session_controls"
            "custom/separator"
            "hyprland/workspaces"
          ];

          modules-center = [
          ];

          modules-right = [
            "bluetooth"
            "battery"
            "custom/spacer"
            "clock"
          ];

          "custom/spacer" = {
            format = " ";

            tooltip = false;
          };

          "custom/separator" = {
            format = " | ";

            tooltip = false;
          };

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
            };

            persistent-workspaces = {
              "*" = 6;
            };
          };

          bluetooth = {
            format-on = "󰂯";
            format-connected = "󰂱";
            format-connected-battery = "󰂱 {device_battery_percentage}";

            tooltip-format-on = "{device_alias} {status}";
            tooltip-format-connected = "{device_alias} {status}\n{device_enumerate}";
          };

          battery = {
            states = {
              warning = 30;
              critical = 15;
            };

            format = "{icon}";
            format-discharging-critical = "{capacity}% {icon}";
            format-icons = ["" "" "" "" ""];

            tooltip-format = "{capacity}%\nTime till: {timeTo}";
          };

          clock = {
          };
        };
      };

      style =
        # CSS
        ''
          window#waybar.statusBar {
            background: transparent;
          }

          window#waybar.statusBar .modules-left {
            background: #24273a;

            border: 2px #6e738d;
            border-right-style: solid;
            border-bottom-style: solid;
            border-radius: 0px 1rem 1rem 0px;
          }
        '';

      systemd.enable = true;
    };
  };
}

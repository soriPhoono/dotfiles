{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  config = lib.mkIf cfg.enable {
    stylix.targets.waybar.enable = false;

    programs.waybar = {
      enable = true;

      settings = {
        statusBar = {
          name = "statusBar";

          layer = "top";

          modules-left = [
            "custom/spacer"
            "hyprland/workspaces"
          ];

          modules-center = [
          ];

          modules-right = [
            "tray"
            "custom/spacer"
            "network"
            "bluetooth"
            "wireplumber"
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

          "hyprland/workspaces" = {
            active-only = true;
            all-outputs = true;

            format = "{icon}";

            format-icons = {
              active = "<span color='#8bd5ca'>󰑊</span>";
              default = "<span color='#cad3f5'>󰑊</span>";
              empty = "<span color='#6e738d'></span>";
              urgent = "<span color='#ee99a0'>󰑊</span>";
            };

            persistent-workspaces = {
              "*" = 6;
            };
          };

          tray = {
            icon-size = 21;
            spacing = 10;
          };

          network = {
            format-disconnected = "<span color='#6e738d'> 󰤮</span>";
            format-wifi = " {icon}";
            format-ethernet = "<span color='#a6da95'> 󰈁</span>";

            format-icons = ["<span color='#ed8796'>󰤟</span>" "<span color='#f5a97f'>󰤢</span>" "<span color='#eed49f'>󰤥</span>" "<span color='#a6da95'>󰤨</span>"];

            on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";

            tooltip-format-disconnected = "{ifname}: Disconnected";
            tooltip-format-wifi = "{ifname}: {essid} ({signalStrength}%)";
            tooltip-format-ethernet = "{ifname}: {essid}";
          };

          bluetooth = {
            format-off = "<span color='#6e738d'> 󰂲</span>";
            format-on = "<span color='#8aadf4'> 󰂯</span>";
            format-connected = "<span color='#91d7e3'> 󰂱</span>";
            format-connected-battery = "<span color='#91d7e3'> 󰂱 {device_battery_percentage}%</span>";

            on-click = "${pkgs.blueberry}/bin/blueberry";

            tooltip-format-on = "{controller_alias} {status}";
            tooltip-format-connected = "{controller_alias} {status}\nConnected: {num_connections}\n{device_enumerate}";
            tooltip-format-enumerate-connected = "{device_alias}: {device_address}";
            tooltip-format-connected-battery = "{controller_alias} {status}\nConnected: {num_connections}\n{device_enumerate}";
            tooltip-format-enumerate-connected-battery = "{device_alias} {device_battery_percentage}%: {device_address}";
          };

          wireplumber = {
            format-muted = "<span color='#f5a97f'> </span>";
            format = "<span color='#eed49f'> {icon}</span>";

            format-icons = ["" "" ""];

            on-click = "${pkgs.pavucontrol}/bin/pavucontrol";

            tooltip-format = "{node_name} ({volume}%)";
          };

          battery = {
            states = {
              warning = 30;
              critical = 15;
            };

            format = "<span color='#a6da95'> {icon}</span>";
            format-warning = "<span color='#eed49f'> {icon}</span>";
            format-critical = "<span color='#ed8796'> {capacity}% {icon}</span>";
            format-icons = ["" "" "" "" ""];

            tooltip-format = "{capacity}%\n{timeTo}";
          };

          clock = {
            format = "<span color='#cad3f5'>{:%I:%M %p}  </span>";
            tooltip-format = "{calendar}";

            calendar = {
              mode = "month";
              mode-mon-col = 3;
              weeks-pos = "right";
              on-scroll = 1;
              format = {
                months = "<span color='#cad3f5'><b>{}</b></span>";
                days = "<span color='#cad3f5'><b>{}</b></span>";
                weeks = "<span color='#cad3f5'><b>W{}</b></span>";
                weekdays = "<span color='#cad3f5'><b>{}</b></span>";
                today = "<span color='#8bd5ca'><b><u>{}</u></b></span>";
              };
            };
            actions = {
              on-click = "mode";
              on-right-click = "shift_reset";
              on-scroll-up = "shift_up";
              on-scroll-down = "shift_down";
            };
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
            background: #363a4f;

            border: 2px #6e738d;
            border-right-style: solid;
            border-bottom-style: solid;
            border-radius: 0px 1rem 1rem 0px;
          }

          window#waybar.statusBar .modules-right {
            background: #363a4f;

            border: 2px #6e738d;
            border-left-style: solid;
            border-bottom-style: solid;
            border-radius: 1rem 0px 0px 1rem;
          }
        '';

      systemd.enable = true;
    };
  };
}

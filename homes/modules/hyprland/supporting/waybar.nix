{ pkgs
, ...
}: {
  programs.waybar = {
    enable = true;

    settings = {
      topBar = {
        layer = "top";
        position = "top";

        spacing = 8;
        height = 60;

        margin-left = 20;
        margin-right = 20;
        margin-top = 10;

        modules-left = [
          "custom/spacer"
          "custom/power"
          "hyprland/workspaces"
        ];

        modules-center = [

        ];

        modules-right = [
          "tray"
          "network"
          "bluetooth"
          "pulseaudio"
          "battery"
          "clock"
          "custom/spacer"
        ];

        "custom/spacer" = {
          format = " ";
        };

        "custom/power" = with pkgs; {
          format = "󱄅";
          on-click = "${wlogout}/bin/wlogout";
          tooltip-format = "Session controls";
        };
        
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            default = "";
            active = "";
          };

          persistent-workspaces = {
            "*" = 6;
          };
        };

        network = {
          format-icons = [
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];

          format-ethernet = "󰈀";
          format-wifi = "{icon}";
          format-disconnected = "󰤭";

          tooltip-format-ethernet = "{ifname} {ipaddr}";
          tooltip-format-wifi = "{ifname} {ipaddr} {essid}";
          tooltip-format-disconnected = "{ifname} Disconnected";
        };

        bluetooth = {
          format-disabled = "󰂯";
          format-connected = "󰂱";
          format-on = "󰂯";
          format-off = "󰂲";

          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-on = "{controller_alias}\t{controller_address}";
          tooltip-format-off = "Disconnected";
        };

        pulseaudio = {
          format = "{icon}";
          format-icons = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];

          tooltip-format = "{volume}%";
        };

        battery = {
          format = "{icon}";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁾"
            "󰂀"
            "󰂂"
            "󰁹"
          ];
        };

        clock = {
          format = "󰥔 {:%H:%M :%p}";

          tooltip-format = "<tt><small>{calendar}</small></tt>";

          calendar = {
            mode = "year";
            mode-mon-col = 3;
            week-pos = "right";
            on-scroll = 1;
            format = {
              months = "<b>{}</b>";
              days = "<b>{}</b>";
              weeks = "<b>W{}</b>";
              weekdays = "<b>{}</b>";
              today = "<b><u>{}</u></b>";
            };
            actions = {
              on-scroll-up = "shift_up";
              on-scroll-down = "shift_down";
            };
          };
        };
      };
    };
  };
}

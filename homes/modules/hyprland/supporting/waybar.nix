{
  programs.waybar = {
    enable = true;

    settings = {
      topBar = {
        layer = "top";
        position = "top";

        spacing = 8;
        height = 40;

        modules-left = [
          "custom/power"
          "hyprland/window"
        ];

        modules-center = [
          
        ];

        modules-right = [
          "tray"
          "network"
          "bluetooth"
          "wireplumber"
          "battery"
          "clock"
        ];

        "custom/power" = {
          format = "󱄅";
          on-click = "wlogout";
          tooltip-format = "Session controls";
        };

        "hyprland/window" = {
          max-length = 20;
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
          format-connected-battery = "󰂱";
          format-connected = "󰂱";
          format-on = "󰂯";
          format-off = "󰂲";

          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-on = "{controller_alias}\t{controller_address}";
          tooltip-format-off = "Disconnected";
        };
      };

      bottomBar = {
        layer = "top";
        position = "bottom";

        modules-left = [
          
        ];

        modules-center = [
          "hyprland/workspaces"
        ];

        modules-right = [
          
        ];

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
      };
    };
  };
}

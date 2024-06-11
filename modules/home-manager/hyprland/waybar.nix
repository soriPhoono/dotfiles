{ pkgs, ... }: {
  programs.waybar = {
    enable = true;

    settings = {
      hud = {
        output = [
          "eDP-1"
        ];

        layer = "top";
        position = "top";
        height = 40;
        margin-top = 15;
        margin-left = 15;
        margin-right = 15;

        modules-left = [
          "hyprland/window"
        ];

        modules-center = [
          "hyprland/workspaces"
        ];

        modules-right = [
          "network"
          "bluetooth"
          "wireplumber"
          "battery"
          "clock"
        ];

        battery = {
          format = "{icon}";
          format-icons = [ "󰁺" "󰁼" "󰁾" "󰂀" "󰂂" "󰁹" ];
          tooltip-format = "{capacity}% ({time})";

          stages = {
            full = 100;
            high = 90;
            medium = 70;
            low = 50;
            warning = 30;
            critical = 10;
          };
        };

        bluetooth = {
          format-disabled = "󰜺";
          format-off = "󰂲";
          format-on = "󰂯";
          format-connected = "󰂱";

          tooltip-format = "{status} {num_connections}\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}";
          tooltip-format-enumerate-connected-battery = "{device_alias} ({device_battery_percentage})";

          on-click = "${pkgs.blueberry}/bin/blueberry";
        };

        clock = {
          format = "{:%H:%M} 󰥔";
          format-alt = "{%A, %B %d, %Y (%R)} 󰃭";
          tooltip-format = "\n<span size='12pt' font='JetBrainsMono Nerd Font Propo'>{calendar}</span>"; # TODO: check font name
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#f5e0dc'><b>{}</b></span>";
              days = "<span color='#eba0ac'><b>{}</b></span>";
              weeks = "<span color='#fab387'><b>W{}</b></span>";
              weekdays = "<span color='#a6e3a1'><b>{}</b></span>";
              today = "<span color='#f38ba8'><b><u>{}</u></b></span>";
            };
            actions = {
              on-click = "shift_reset";
              on-click-right = "mode";
              on-scroll-up = "shift_up";
              on-scroll-down = "shift_down";
            };
          };
        };
      };
    };

    style = ''

    '';
  };
}

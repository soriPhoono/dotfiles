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
          "image"
          "hyprland/workspaces"
          "hyprland/window"
        ];

        modules-center = [
          "mpris"
        ];

        modules-right = [
          "tray"
          "network"
          "bluetooth"
          "pulseaudio"
          "battery"
          "clock"
        ];

        "custom/spacer" = {
          text = " ";
        };

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
          tooltip-format-enumerate-connected-battery = "{device_alias} ({device_battery_percentage}%)";

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

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "󰈹";
            "3" = "";
            "4" = "";
            "5" = "";
            empty = "";
            active = "";
            urgent = "󰀨";
            default = "";
          };
          persistent-workspaces = {
            "*" = 6;
          };
        };

        "hyprland/window" = {
          format = "Active window: {class}";
        };

        image = {
          path = ../../../assets/icons/Nix_snowflake.png;
          size = 24;

          on-click = "${pkgs.xdg-utils}/bin/xdg-open https://nixos.org"; # TODO: change to the right command
        };

        mpris = {
          format-playing = "󰐊 {artist} - {title}";
          format-paused = "󰏤 {artist} - {title}";
          format-stopped = "󰓛 {artist} - {title}";

          on-click = "${pkgs.playerctl}/bin/playerctl play-pause";
        };

        network = {
          format-ethernet = "󰈀";
          format-wifi = "{icon}";
          format-disconnected = "󰤮";

          tooltip-format-ethernet = "{ifname} {essid} {ipaddr}";
          tooltip-format-wifi = "{essid} {ipaddr} {signalStrength}%";
          tooltip-format-disconnected = "";

          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];

          on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
          on-right-click = "~/.local/bin/nm-toggle.sh";
        };

        pulseaudio = {
          format = "{icon}";
          format-muted = "󰝟";
          format-bluetooth = "󰂰";

          tooltip-format = "{volume}% {desc}";

          format-icons = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];

          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          on-right-click = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };

        tray = {
          icon-size = 24;
          spacing = 10;
        };
      };
    };

    style = ''

    '';
  };
}

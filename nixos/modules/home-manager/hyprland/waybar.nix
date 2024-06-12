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

        modules-left = [
          "custom/logo"
          "clock"
          "hyprland/window"
        ];

        modules-center = [
          "hyprland/workspaces"
        ];

        modules-right = [
          "tray"
          "bluetooth"
          "pulseaudio"
          "network"
          "battery"
        ];

        reload_style_on_change = true;

        "custom/logo" = {
          format = "󱄅";
          tooltip = false;
        };

        "hyprland/workspaces" = {
          format = "<span size='14pt'>{icon}</span>";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "6" = "";
            active = "";
            default = "";
          };
          persistent-workspaces = {
            "*" = 6;
          };
        };

        clock = {
          format = "{:%I:%M:%S %p}";
          interval = 1;
          tooltip-format = "\n<big>{:%Y %B}</big>\n<tt>{calendar}</tt>";
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
              on-scroll-up = "shift_up";
              on-scroll-down = "shift_down";
            };
          };
        };

        bluetooth = {
          format-on = "<span size='14pt'>󰂯</span>";
          format-off = "";
          format-disabled = "<span size='14pt'>󰂲</span>";
          format-connected = "<span size='14pt'>󰂱</span>";

          tooltip-format = "{status} {num_connections}\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}";
          tooltip-format-enumerate-connected-battery = "{device_alias} ({device_battery_percentage}%)";

          on-click = "${pkgs.blueberry}/bin/blueberry";
          # TODO: toggle bluetooth on right click
        };

        network = {
          format-wifi = "<span size='14pt'>{icon}</span>";
          format-ethernet = "<span size='14pt'>󰈀</span>";
          format-disconnected = "<span size='14pt'>󰤮</span>";

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

          on-click = "";
          on-right-click = "~/.local/bin/nm-toggle.sh";
        };

        battery = {
          format = "<span size='14pt'>{icon}</span>";
          format-icons = [ "󰁺" "󰁼" "󰁾" "󰂀" "󰂂" "󰁹" ];
          tooltip-format = "{capacity}% ({time})";

          states = {
            warning = 30;
            critical = 10;
          };
        };

        pulseaudio = {
          format = "<span size='14pt'>{icon}</span>";
          format-muted = "<span size='14pt'>󰝟</span>";
          format-bluetooth = "<span size='14pt'>󰂰 {icon}</span>";

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
          icon-size = 14;
          spacing = 10;
        };
      };
    };

    style = ''
      * {
        border: none;
        font-size: 14px;
        font-family: "JetBrainsMono Nerd Font,JetBrainsMono NF" ;
        min-height: 25px;
      }

      window#waybar {
      background: transparent;
      margin: 5px;
      }

      #custom-logo {
      padding: 0 10px;
      }

      .modules-right {
      padding-left: 5px;
      border-radius: 15px 0 0 15px;
      margin-top: 2px;
      background: #000000;
      }

      .modules-center {
      padding: 0 15px;
      margin-top: 2px;
      border-radius: 15px 15px 15px 15px;
      background: #000000;
      }

      .modules-left {
      border-radius: 0 15px 15px 0;
      margin-top: 2px;
      background: #000000;
      }

      #battery,
      #custom-clipboard,
      #custom-colorpicker,
      #custom-powerDraw,
      #bluetooth,
      #pulseaudio,
      #network,
      #disk,
      #memory,
      #backlight,
      #cpu,
      #temperature,
      #custom-weather,
      #idle_inhibitor,
      #jack,
      #tray,
      #window,
      #workspaces,
      #clock {
      padding: 0 5px;
      }
      #pulseaudio {
      padding-top: 3px;
      }

      #temperature.critical,
      #pulseaudio.muted {
      color: #FF0000;
      padding-top: 0;
      }

      #clock{
      color: #5fd1fa;
      }

      #battery.charging {
        color: #ffffff;
        background-color: #26A65B;
      }

      #battery.warning:not(.charging) {
        background-color: #ffbe61;
        color: black;
      }

      #battery.critical:not(.charging) {
        background-color: #f53c3c;
        color: #ffffff;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      @keyframes blink {
        to {
            background-color: #ffffff;
            color: #000000;
        }
      }
    '';
  };
}

{ pkgs, ... }: {
  home.file = {
    ".local/bin/nm-toggle.sh".source = ../../../scripts/nm-toggle.sh;
  };

  programs.waybar = {
    enable = true;

    settings = {
      hud = {
        output = [
          "eDP-1"
        ];

        layer = "top";
        position = "top";
        margin-top = 15;
        margin-left = 15;
        margin-right = 15;

        modules-left = [
          "custom/nixos"
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

        "custom/nixos" = {
          text = "<span size='14pt'>󱄅</span>";

          on-click = "${pkgs.xdg-utils}/bin/xdg-open https://nixos.org/"; # TODO: change this to proper invocation
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

        bluetooth = {
          format-disabled = "<span size='14pt'>󰜺</span>";
          format-off = "<span size='14pt'>󰂲</span>";
          format-on = "<span size='14pt'>󰂯</span>";
          format-connected = "<span size='14pt'>󰂱</span>";

          tooltip-format = "{status} {num_connections}\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}";
          tooltip-format-enumerate-connected-battery = "{device_alias} ({device_battery_percentage}%)";

          on-click = "${pkgs.blueberry}/bin/blueberry";
          # TODO: toggle bluetooth on right click
        };

        clock = {
          format = "{:%H:%M} <span size='14pt'>󰥔</span>";
          format-alt = "{%A, %B %d, %Y (%R)} 󰃭";
          tooltip-format = "\n<span size='12pt'>{calendar}</span>"; # TODO: check font name
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
          format = "<span size='14pt'>{icon}</span>";
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
          format = "<span size='14pt'>Active window: {class}</span>";
        };

        mpris = {
          format-playing = "<span size='14pt'>󰐊 {artist} - {title}</span>";
          format-paused = "<span size='14pt'>󰏤 {artist} - {title}</span>";
          format-stopped = "<span size='14pt'>󰓛 {artist} - {title}</span>";

          on-click = "${pkgs.playerctl}/bin/playerctl play-pause";
        };

        network = {
          format-ethernet = "<span size='14pt'>󰈀</span>";
          format-wifi = "<span size='14pt'>{icon}</span>";
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

          on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
          on-right-click = "~/.local/bin/nm-toggle.sh";
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
          icon-size = 24;
          spacing = 10;
        };
      };
    };

    style = ''
      * {
        font-family: "AurulentSansM Nerd Font Propo";

        padding-left: 5px;
        padding-right: 5px;
      }

      #battery {
        font-size: 14pt;

        color: #a6e3a1;
      }

      #battery.warning {
        font-size: 14pt;

        color: #f9e2af;
      }

      #battery.critical {
        font-size: 14pt;

        color: #f38ba8;
      }

      #bluetooth.disabled {
        font-size: 14pt;

        color: #f38ba8;
      }

      #bluetooth.on {
        font-size: 14pt;

        color: #89dceb;
      }

      #bluetooth.connected {
        font-size: 14pt;

        color: #89b4fa;
      }
    '';
  };
}

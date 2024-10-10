{ lib, pkgs, config, ... }:
let
  cfg = config.desktop.programs.waybar;

  serviceToggle = with pkgs;
    writeShellApplication {
      name = "service_toggle.sh";

      runtimeInputs = [ networkmanager tlp libnotify ];

      text = ''
        #!/bin/bash

        service=$1

        case $service in
          "network")
            status=$(nmcli radio wifi)

            if [[ "$status" = "enabled" ]]; then
              nmcli radio wifi off

              notify-send Disabled wifi
            else
              nmcli radio wifi on

              notify-send Enabled wifi
            fi
            ;;
          "bluetooth")
            status=$(bluetooth | awk '{ print $3 }')

            if [[ "$status" = "on" ]]; then
              bluetooth off

              notify-send Disabled bluetooth
            else
              bluetooth on

              notify-send Enabled bluetooth
            fi
            ;;
          *)
            notify-send Bad argument to service toggle script from waybar
            ;;
        esac
      '';
    };
in {
  options = {
    desktop.programs.waybar.enable = lib.mkEnableOption "Enable waybar";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;

      settings = with pkgs; {
        topBar = {
          layer = "top";
          position = "top";

          spacing = 8;

          margin-left = 20;
          margin-right = 20;
          margin-top = 20;

          modules-left = [
            "custom/spacer"
            "custom/power"
            "custom/separator"
            "hyprland/workspaces"
            "custom/spacer"
          ];

          modules-right = [
            "custom/spacer"
            "tray"
            "custom/separator"
            "network"
            "bluetooth"
            "pulseaudio"
            "battery"
            "custom/separator"
            "clock"
            "custom/spacer"
          ];

          "custom/spacer" = {
            format = " ";

            tooltip = false;
          };

          "custom/separator" = {
            format = "|";

            tooltip = false;
          };

          "custom/power" = with pkgs; {
            format = "<span color='#7EBAE4'>󱄅</span>";
            tooltip-format = "Session controls";

            on-click = "${wlogout}/bin/wlogout";
          };

          "hyprland/workspaces" = {
            format = "{icon}";
            format-icons = {
              default = "";
              active = "<span color='#a6e3a1'></span>";
            };

            persistent-workspaces = { "*" = 6; };
          };

          network = {
            format-icons = [
              "<span color='#eba0ac'>󰤟</span>"
              "<span color='#f9e2af'>󰤢</span>"
              "<span color='#a6e3a1'>󰤥</span>"
              "<span color='#a6e3a1'>󰤨</span>"
            ];

            format-ethernet = "<span color='#a6e3a1'>󰈀</span>";
            format-wifi = "{icon}";
            format-disconnected = "<span color='#f38ba8'>󰤭</span>";

            tooltip-format-ethernet = "{ifname} {ipaddr}";
            tooltip-format-wifi = "{ifname} {ipaddr} {essid}";
            tooltip-format-disconnected = "{ifname} Disconnected";

            on-click = "${networkmanagerapplet}/bin/nm-connection-editor";
            on-right-click = "${serviceToggle}/bin/service_toggle.sh network";
          };

          bluetooth = {
            format-disabled = "<span color='#f38ba8'>󰂯</span>";
            format-connected = "<span color='#89b4fa'>󰂱</span>";
            format-on = "<span color='#fab387'>󰂯</span>";
            format-off = "<span color='#6c7086'>󰂲</span>";

            tooltip-format-enumerate-connected =
              "{device_alias}	{device_address}";
            tooltip-format-connected = ''
              {controller_alias}	{controller_address}

              {device_enumerate}'';
            tooltip-format-on = "{controller_alias}	{controller_address}";
            tooltip-format-off = "Disconnected";

            on-click = "${blueberry}/bin/blueberry";
            on-right-click = "${serviceToggle}/bin/service_toggle.sh bluetooth";
          };

          pulseaudio = {
            format = "<span color='#f9e2af'>{icon}</span>";
            format-icons = [ "󰕿" "󰖀" "󰕾" ];

            tooltip-format = "{desc} {volume}% {icon}";

            on-click = "${pavucontrol}/bin/pavucontrol";
            on-right-click =
              "${wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          };

          battery = {
            format = "{icon}";
            format-icons = [
              "<span color='#f38ba8'>󰁺</span>"
              "<span color='#eba0ac'>󰁻</span>"
              "<span color='#fab387'>󰁼</span>"
              "<span color='#fab387'>󰁾</span>"
              "<span color='#f9e2af'>󰂀</span>"
              "<span color='#a6e3a1'>󰂂</span>"
              "<span color='#a6e3a1'>󰁹</span>"
            ];
          };

          clock = {
            format = "<span color='#fab387'>󰥔</span> {:%H:%M %p}";

            tooltip = false;
          };

          tray = {
            icon-size = 21;
            spacing = 10;
          };
        };
      };

      style =
        # css
        ''
          window#waybar {
            background-color: transparent;
          }

          .modules-left {
            background-color: @theme_base_color;
            border-radius: 40px;
          }

          .modules-right {
            background-color: @theme_base_color;
            border-radius: 40px;
          }

          #workspaces button {
            border-color: transparent;
            border-radius: 50%;
          }
        '';
    };
  };
}

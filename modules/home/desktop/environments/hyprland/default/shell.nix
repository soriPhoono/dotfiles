{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.environments.hyprland.default;
in
  with lib; {
    config = mkIf cfg.enable {
      programs = {
        ashell = {
          enable = true;
          settings = {
            enable_esc_key = true;
            opacity = 0.8;

            outputs = {
              Targets = [
                "eDP-1"
              ];
            };

            window_title = {
              truncate_title_after_length = 12;
            };

            settings = {
              logout_cmd = "${pkgs.uwsm}/bin/uwsm stop";
              lock_cmd = "${pkgs.hyprlock}/bin/hyprlock &";
              audio_sinks_more_cmd = "${pkgs.pavucontrol}/bin/pavucontrol -t 3";
              audio_sources_more_cmd = "${pkgs.pavucontrol}/bin/pavucontrol -t 4";
              wifi_more_cmd = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
              vpn_more_cmd = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
              bluetooth_more_cmd = "${pkgs.blueman}/bin/blueman-manager";
              remove_idle_btn = true;
              peripheral_indicators = {
                Specific = [
                  "Keyboard"
                  "Mouse"
                  "Headphones"
                  "Gamepad"
                ];
              };
              indicators = [
                "Audio"
                "Network"
                "Vpn"
                "Bluetooth"
                "PowerProfile"
                "Battery"
                "PeripheralBattery"
              ];
            };

            clock = {
              format = "%l:%M %P, %a %h%e";
            };

            modules = {
              left = [
                [
                  "Clock"
                  "Workspaces"
                ]
              ];
              center = [
                "MediaPlayer"
              ];
              right = [
                "Tray"
                [
                  "Privacy"
                  "Settings"
                ]
              ];
            };
          };
        };

        vicinae = {
          enable = true;
        };
      };

      wayland.windowManager.hyprland.settings = {
        exec-once = [
          "${pkgs.uwsm}/bin/uwsm app -t service -s s ${pkgs.swww}/bin/swww-daemon &"
          "${pkgs.uwsm}/bin/uwsm app -t service -s s ${pkgs.ashell}/bin/ashell &"
          "${pkgs.uwsm}/bin/uwsm app -t service -s b ${pkgs.vicinae}/bin/vicinae server &"
        ];

        bind = [
          "$mod, A, exec, ${pkgs.uwsm}/bin/uwsm app ${pkgs.vicinae}/bin/vicinae toggle"
        ];

        layerrule = [
          "blur,vicinae"
          "ignorealpha 0, vicinae"
          "noanim, vicinae"
        ];
      };
    };
  }

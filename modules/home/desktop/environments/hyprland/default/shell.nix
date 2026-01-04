{
  lib,
  pkgs,
  config,
  nixosConfig,
  ...
}: let
  cfg = config.desktop.environments.hyprland.default;
in
  with lib; {
    config = mkIf cfg.enable {
      programs = {
        quickshell = {
          enable = true;
        };

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
              logout_cmd = "${nixosConfig.programs.uwsm.package}/bin/uwsm stop";
              lock_cmd = "${nixosConfig.programs.uwsm.package}/bin/uwsm app ${config.programs.hyprlock.package}/bin/hyprlock &";
              audio_sinks_more_cmd = "${nixosConfig.programs.uwsm.package}/bin/uwsm app -- ${pkgs.pavucontrol}/bin/pavucontrol -t 3";
              audio_sources_more_cmd = "${nixosConfig.programs.uwsm.package}/bin/uwsm app -- ${pkgs.pavucontrol}/bin/pavucontrol -t 4";
              wifi_more_cmd = "${nixosConfig.programs.uwsm.package}/bin/uwsm app ${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
              vpn_more_cmd = "${nixosConfig.programs.uwsm.package}/bin/uwsm app ${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
              bluetooth_more_cmd = "${nixosConfig.programs.uwsm.package}/bin/uwsm app ${pkgs.blueman}/bin/blueman-manager";
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

      home.packages = with pkgs; [
        awww
      ];

      wayland.windowManager.hyprland.settings = {
        exec-once = [
          "${nixosConfig.programs.uwsm.package}/bin/uwsm app -t service -s s ${pkgs.awww}/bin/awww-daemon &"
          "${nixosConfig.programs.uwsm.package}/bin/uwsm app -t service -s s ${config.programs.ashell.package}/bin/ashell &"
          "${nixosConfig.programs.uwsm.package}/bin/uwsm app -t service -s b ${config.programs.vicinae.package}/bin/vicinae server &"
        ];

        bind = [
          "$mod, A, exec, ${nixosConfig.programs.uwsm.package}/bin/uwsm app ${config.programs.vicinae.package}/bin/vicinae toggle"
        ];

        layerrule = [
          "blur,vicinae"
          "ignorealpha 0, vicinae"
          "noanim, vicinae"
        ];
      };
    };
  }

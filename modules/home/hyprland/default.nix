{ inputs, lib, pkgs, config, ... }:
let cfg = config.hyprland;
in {
  options = {
    hyprland.enable = lib.mkEnableOption "Enable personal hyprland configuration";
  };

  config = lib.mkIf cfg.enable {
    qt.enable = true;

    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        # Variables
        "$mod" = "SUPER";

        general.border_size = 3;

        decoration = {
          rounding = 10;

          active_opacity = 0.8;
          inactive_opacity = 0.8;

          dim_inactive = true;

          blur.xray = true;
        };

        input = {
          repeat_rate = 20;
          repeat_delay = 300;

          accel_profile = "flat";

          natural_scroll = true;

          touchpad = {
            natural_scroll = true;
            clickfinger_behavior = true;
            tap-to-click = true;
          };
        };

        misc.disable_hyprland_logo = false;
        xwayland.force_zero_scaling = true;
        cursor.no_hardware_cursors = true;

        # Keybindings
        bind = [
          "$mod, Q, killactive,"

          "$mod, B, exec, firefox"
          "$mod, RETURN, exec, alacritty"
        ] ++ (builtins.concatLists (builtins.genList (
          x: let
            ws = let
              c = (x + 1) / 10;
            in
              builtins.toString (x + 1 - (c * 10));
          in [
            "$mod, ${ws}, workspace, ${toString (x + 1)}"
            "$mod SHIFT, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
          ]
        ) 10));

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, Control_L, movewindow"
          "$mod, mouse:273, resizewindow"
          "$mod, ALT_L, resizewindow"
        ];
      };
    };

    programs = {
      alacritty = {
        enable = true;

        settings = {
          window = {
            blur = true;

            decorations = "None";
            startup_mode = "Maximized";
          };

          cursor.style = "Beam";
        };
      };

      hyprlock = {
        enable = true;

        settings = {
          general = {
            disable_loading_bar = true;
            hide_cursor = true;
            grace = 5;
            ignore_empty_input = true;
            text_trim = true;
          };

          background = [
            {
              path = "screenshot";

              blur_passes = 1;
              blur_size = 7;
              noise = 0.0117;
              contrast = 0.8916;
              brightness = 0.8172;
              vibrancy = 0.1696;
              vibrancy_darkness = 0.0;
            }
          ];

          label = [
            {
              text = "Hello, $USER!\nAttempts: $ATTEMPTS[None]";
              text_align = "center";
              halign = "center";
              valign = "center";
            }
            {
              text = "$TIME";
              text_align = "center";
              halign = "right";
              valign = "bottom";
            }
          ];

          input-field = [
            {
              fade_on_empty = true;
              placeholder_text = "Input password...";
              hide_input = true;
              halign = "center";
              valign = "center";
            }
          ];
        };
      };

      anyrun = {
        enable = true;
        config = {
          plugins = [
            # An array of all the plugins you want, which either can be paths to the .so files, or their packages
            inputs.anyrun.packages.${pkgs.system}.applications
            inputs.anyrun.packages.${pkgs.system}.websearch
          ];
          x = { fraction = 0.5; };
          y = { fraction = 0.3; };
          width = { fraction = 0.3; };
          hideIcons = false;
          ignoreExclusiveZones = false;
          layer = "overlay";
          hidePluginInfo = false;
          closeOnClick = false;
          showResultsImmediately = false;
          maxEntries = null;
        };
        extraCss = ''
          .some_class {
            background: red;
          }
        '';

        extraConfigFiles."some-plugin.ron".text = ''
          Config(
            // for any other plugin
            // this file will be put in ~/.config/anyrun/some-plugin.ron
            // refer to docs of xdg.configFile for available options
          )
        '';
      };
    };

    services = {
      hypridle = {
        # enable = true;

        settings = {
          general = {
            ignore_dbus_inhibit = false;
            lock_cmd = "pidof hyprlock || hyprlock";
            before_sleep_cmd = "loginctl lock-session";
            after_sleep_cmd = "hyprctl dispatch dpms on";
          };

          listener = [
            {
              timeout = 300;
              on-timeout = "brightnessctl -s set 10 && brightnessctl -sd asus:kbd_backlight set 0";
              on-resume = "brightnessctl -r && brightnessctl -rd asus:kbd_backlight";
            }
            {
              timeout = 900;
              on-timeout = "loginctl lock-session";
            }
            {
              timeout = 1200;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
            {
              timeout = 1800;
              on-timeout = "systemctl suspend";
            }
          ];
        };
      };

      mako = {
        enable = true;

        anchor = "bottom-right";
        borderRadius = 10;
        borderSize = 3;
      };
    };
  };
}

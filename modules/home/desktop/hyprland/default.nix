{ lib, pkgs, config, ... }:
let cfg = config.desktop.hyprland;
in {
  options = {
    desktop.hyprland.enable = lib.mkEnableOption "Enable personal hyprland configuration";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      clipman
      libnotify
      brightnessctl
      wl-clipboard-rs
      lxqt.lxqt-policykit
    ];

    wayland.windowManager.hyprland = {
      enable = true;

      systemd.variables = [ "--all" ];

      settings = {
        # Variables
        "$mod" = "SUPER";

        general.border_size = 3;

        decoration = {
          rounding = 10;

          active_opacity = 0.9;
          inactive_opacity = 0.9;

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

        misc = {
          vfr = true;
          vrr = 1;
          animate_manual_resizes = false;
          animate_mouse_windowdragging = false;
          focus_on_activate = true;
          disable_hyprland_logo = true;
          enable_swallow = false;
          swallow_regex = "(foot|kitty|allacritty|Alacritty)";
        };
        xwayland.force_zero_scaling = true;
        cursor.no_hardware_cursors = true;

        exec = [

        ];

        exec-once = with pkgs; [
          "lxqt-policykit-agent"
          "wl-paste --watch clipman store"
        ];

        # Keybindings
        bind = [
          "$mod, Q, killactive,"

          "$mod, A, exec, anyrun"
          "$mod, L, exec, wlogout"
          "$mod, E, exec, thunar"
          "$mod, RETURN, exec, alacritty"

          "$mod, B, exec, google-chrome-stable"
          "$mod, C, exec, code"
          "$mod, N, exec, obsidian"
        ] ++ (builtins.concatLists (builtins.genList
          (
            x:
            let
              ws =
                let
                  c = (x + 1) / 10;
                in
                builtins.toString (x + 1 - (c * 10));
            in
            [
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

    terminal.emulators.alacritty.enable = true;

    desktop = {
      programs.util = {
        anyrun.enable = true;
        ui_toolkits.enable = true;
      };

      services = {
        gnome-keyring.enable = true;

        hypridle.enable = true;

        mako.enable = true;
      };
    };
  };
}

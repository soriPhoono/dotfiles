{
  lib,
  pkgs,
  config,
  ...
}:
with lib; {
  imports = [
    ./conf/hypr.nix

    ./shell.nix
  ];

  options.desktop.environments.hyprland.default = {
    enable = mkEnableOption "Enable default hyprland desktop";
  };

  config = mkIf (config.desktop.environments.hyprland.enable && !config.desktop.environments.hyprland.custom) {
    desktop.environments.hyprland.default.enable = true;

    wayland.windowManager.hyprland = {
      systemd.enable = false;
      settings = {
        "$mod" = "SUPER";
        bind =
          [
            # Window management
            "$mod, Q, killactive, "
            "$mod, F, fullscreen, "
            "$mod, V, togglefloating, "
            "$mod, P, pseudo, "
            "$mod, S, togglesplit, "

            # Cycle windows
            "$mod, Tab, cyclenext, "
            "$mod SHIFT, Tab, cyclenext, prev"

            # Screenshotting
            "$mod, Print, exec, ${config.programs.hyprshot.package}/bin/hyprshot -m active -m output"
            "$mod SHIFT, Print, exec, ${config.programs.hyprshot.package}/bin/hyprshot -m active -m window"
            "$mod ALT, Print, exec, ${config.programs.hyprshot.package}/bin/hyprshot -m region"
          ]
          ++ (
            # workspaces
            # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
            builtins.concatLists (builtins.genList (
                i: let
                  ws = i;
                in [
                  "$mod, ${toString i}, workspace, ${toString ws}"
                  "$mod SHIFT, ${toString i}, movetoworkspace, ${toString ws}"
                ]
              )
              9)
          );

        # Repeatable bindings for window controls
        binde = [
          # Focus movement (arrow keys)
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          # Focus movement (vim keys)
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"

          # Window movement (arrow keys)
          "$mod SHIFT, left, movewindow, l"
          "$mod SHIFT, right, movewindow, r"
          "$mod SHIFT, up, movewindow, u"
          "$mod SHIFT, down, movewindow, d"

          # Window movement (vim keys)
          "$mod SHIFT, H, movewindow, l"
          "$mod SHIFT, L, movewindow, r"
          "$mod SHIFT, K, movewindow, u"
          "$mod SHIFT, J, movewindow, d"

          # Window resizing (arrow keys)
          "$mod CTRL, left, resizeactive, -40 0"
          "$mod CTRL, right, resizeactive, 40 0"
          "$mod CTRL, up, resizeactive, 0 -40"
          "$mod CTRL, down, resizeactive, 0 40"

          # Window resizing (vim keys)
          "$mod CTRL, H, resizeactive, -40 0"
          "$mod CTRL, L, resizeactive, 40 0"
          "$mod CTRL, K, resizeactive, 0 -40"
          "$mod CTRL, J, resizeactive, 0 40"
        ];

        bindm = [
          "ALT, mouse:272, movewindow"
        ];

        bindc = [
          "ALT, mouse:272, togglefloating"
        ];
      };
    };
  };
}

{
  lib,
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
            "$mod, Q, killactive, "
          ]
          ++ (
            # workspaces
            # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
            builtins.concatLists (builtins.genList (
                i: let
                  ws = i + 1;
                in [
                  "$mod, ${toString i}, workspace, ${toString ws}"
                  "$mod SHIFT, ${toString i}, movetoworkspace, ${toString ws}"
                ]
              )
              9)
          );
      };
    };
  };
}

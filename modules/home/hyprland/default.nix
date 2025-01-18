{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.hyprland;
in {
  options.hyprland = {
    enable = lib.mkEnableOption "Enable hyprland desktop configuration";
  };

  config = {
    programs.kitty.enable = true;
    wayland.windowManager.hyprland = {
      enable = true;

      systemd.variables = ["--all"];

      settings = {
        "$mod" = "SUPER";

        bind =
          [
            "$mod, Return, exec, ${pkgs.kitty}/bin/kitty"
            "$mod, B, exec, ${pkgs.firefox}/bin/firefox"
          ]
          ++ (
            builtins.concatLists (builtins.genList (
                i: let
                  ws = i + 1;
                in [
                  "$mod, code:1${toString i}, workspace, ${toString ws}"
                  "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                ]
              )
              9)
          );
      };
    };
  };
}

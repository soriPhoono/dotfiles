{ inputs, lib, pkgs, config, ... }:
let cfg = config.hyprland;
in {
  options = {
    hyprland.enable = lib.mkEnableOption "Enable personal hyprland configuration";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        "$mod" = "SUPER";

        bind = [
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
    };
  };
}

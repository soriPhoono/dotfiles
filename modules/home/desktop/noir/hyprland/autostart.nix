{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = let
      # TODO: finish this
      bootstrap = pkgs.writeShellApplication {
        name = "bootstrap.sh";

        runtimeInputs = with pkgs; [
          swww
          waybar
        ];

        text = ''
          sleep 0.1

          if pgrep swww-daemon; then swww kill; fi

          swww-daemon &

          for wallpaper in $(command ls ~/Pictures/Wallpapers/)
          do
            swww img "$wallpaper"
          done

          if pgrep waybar; then pkill waybar; fi

          waybar &
        '';
      };
    in {
      exec = [
        "${bootstrap}/bin/bootstrap.sh"
      ];

      exec-once = [
        "${pkgs.wl-clipboard-rs}/bin/wl-paste --watch cliphist store &"
        "${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard both &"
      ];
    };
  };
}

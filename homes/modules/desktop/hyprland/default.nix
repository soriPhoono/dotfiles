{ inputs, lib, pkgs, config, ... }:
let cfg = config.desktop.hyprland;
in {
  imports = [ ./animations.nix ./autostart.nix ./binds.nix ./general.nix ];

  options = {
    desktop.hyprland = {
      enable = lib.mkEnableOption "Enable hyprland desktop";
      extraSettings = lib.mkOption {
        type = with lib.types; attrs;
        description = "Extra hyprland settings";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    desktop = {
      enable = true;
      programs = {
        enable = true;
        alacritty.enable = true;
        firefox.enable = true;
        fuzzel.enable = true;
        hyprlock.enable = true;
        waybar.enable = true;
        wlogout.enable = true;
      };
      services = {
        hypridle.enable = true;
        mako = {
          enable = true;
          rounding = 10;
          border_size = 3;
        };
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      package =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

      systemd.variables = [ "--all" ];

      settings = {
        env = [
          "XDG_SESSION_DESKTOP,Hyprland"

          "HYPRCURSOR_SIZE,24"
          "XCURSOR_SIZE,24"

          "GDK_BACKEND,wayland,x11,*"
          "QT_QPA_PLATFORM,wayland;xcb"
          "SDL_VIDEODRIVER,wayland"
          "CLUTTER_BACKEND,wayland"

          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        ];
      } // cfg.extraSettings;
    };
  };
}

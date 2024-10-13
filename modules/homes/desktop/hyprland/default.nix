{ lib, config, ... }:
let cfg = config.desktop.hyprland;
in {
  imports = [ ./rules.nix ./autostart.nix ./binds.nix ./general.nix ];

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
        fuzzel.enable = true;
        hyprlock.enable = true;
        wlogout.enable = true;
      };
      services = {
        hypridle.enable = true;
        mako = {
          enable = true;
          rounding =
            config.wayland.windowManager.hyprland.settings.decoration.rounding;
          border_size =
            config.wayland.windowManager.hyprland.settings.general.border_size;
        };
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;

      systemd.variables = [ "--all" ];

      settings = {
        env = [
          "XDG_SESSION_DESKTOP,Hyprland"

          "HYPRCURSOR_SIZE,24"
          "XCURSOR_SIZE,24"

          "NIXOS_OZONE_WL,1"
          "GDK_BACKEND,wayland,x11,*"
          "QT_QPA_PLATFORM,wayland;xcb"
          # "SDL_VIDEODRIVER,wayland"
          "CLUTTER_BACKEND,wayland"

          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        ];
      } // cfg.extraSettings;
    };
  };
}

{ inputs, lib, pkgs, config, ... }:
let cfg = config.desktop.hyprland;
in {
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
    desktop.enable = true;

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
      } // (import ./general.nix) // (import ./autostart.nix { inherit pkgs; })
        // (import ./binds.nix { inherit pkgs; }) // (import ./animations.nix)
        // cfg.extraSettings;
    };

    programs = {
      hyprlock = import ../programs/hyprlock.nix;
      alacritty = import ../programs/alacritty.nix;
      fuzzel = import ../programs/fuzzel.nix;
      waybar = import ../programs/waybar.nix { inherit pkgs; };
      wlogout = import ../programs/wlogout.nix;
      firefox = import ../programs/firefox.nix { inherit pkgs; };
    };

    services = {
      mako = import ../services/mako.nix { inherit config pkgs; };
      hypridle = import ../services/hypridle.nix;
    };
  };
}

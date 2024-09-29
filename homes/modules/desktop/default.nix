{ inputs, lib, pkgs, config, ... }:
let cfg = config.desktop;
in {
  options = {
    desktop.enable =
      lib.mkEnableOption "Enable desktop tooling and required configuration";

    desktop.extraHyprSettings = lib.mkOption {
      type = with lib.types; attrs;
      description = "Extra hyprland settings";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        btop
        nvtopPackages.full

        gnome-disk-utility

        obsidian

        discord
      ];
    };

    xdg = {
      portal = {
        extraPortals = with pkgs; [
          xdg-desktop-portal-hyprland
          xdg-desktop-portal-gtk
        ];
      };
    };

    gtk = {
      enable = true;

      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };
    };

    qt = {
      enable = true;

      platformTheme.name = "gtk";
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
      } // (import ./config)
        // (import ./config/autostart.nix { inherit pkgs; })
        // (import ./config/binds.nix { inherit pkgs; })
        // (import ./config/animations.nix) // cfg.extraHyprSettings;
    };

    programs = {
      hyprlock = import ./hyprlock.nix;
      alacritty = import ./supporting/alacritty.nix;
      fuzzel = import ./supporting/fuzzel.nix;
      waybar = import ./supporting/waybar.nix { inherit pkgs; };
      wlogout = import ./supporting/wlogout.nix;

      firefox = {
        enable = true;

        package = pkgs.wrapFirefox
          (pkgs.firefox-unwrapped.override { pipewireSupport = true; }) { };
      };
    };

    services = {
      mako = import ./supporting/mako.nix { inherit config pkgs; };
      hypridle = import ./hypridle.nix;
    };
  };
}

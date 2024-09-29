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
      } // (import ./hyprland/general.nix)
        // (import ./hyprland/autostart.nix { inherit pkgs; })
        // (import ./hyprland/binds.nix { inherit pkgs; })
        // (import ./hyprland/animations.nix) // cfg.extraHyprSettings;
    };

    programs = {
      hyprlock = import ./programs/hyprlock.nix;
      alacritty = import ./programs/alacritty.nix;
      fuzzel = import ./programs/fuzzel.nix;
      waybar = import ./programs/waybar.nix { inherit pkgs; };
      wlogout = import ./programs/wlogout.nix;
      firefox = import ./programs/firefox.nix { inherit pkgs; };
    };

    services = {
      mako = import ./services/mako.nix { inherit config pkgs; };
      hypridle = import ./services/hypridle.nix;
    };
  };
}

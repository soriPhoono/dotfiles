{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  imports = [
    ./hyprland/autostart.nix
    ./hyprland/binds.nix
    ./hyprland/general.nix
    ./hyprland/rules.nix
  ];

  options.desktop.noir = {
    enable = lib.mkEnableOption "Enable hyprland desktop with sane defaults";
  };

  config = lib.mkIf cfg.enable {
    desktop = {
      programs = {
        fuzzel.enable = true;
        hyprlock.enable = true;
        nautilus.enable = true;
        waybar.enable = true;
      };
      services = {
        gammastep.enable = true;
        gnome-keyring.enable = true;
        hypridle.enable = true;
        mako.enable = true;
      };
    };

    stylix.targets.hyprland.hyprpaper.enable = false;

    home.file = {
      "Pictures/Wallpapers".source = ../../../../assets/wallpapers;
    };

    xdg.portal = {
      enable = true;

      xdgOpenUsePortal = true;

      config = {
        common.default = ["gtk"];
        hyprland.default = ["gtk" "hyprland"];
      };

      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
    };

    gtk.iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    wayland.windowManager.hyprland = {
      enable = true;

      systemd.variables = ["--all"];
    };
  };
}

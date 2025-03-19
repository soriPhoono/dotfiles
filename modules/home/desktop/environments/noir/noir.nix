{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.environments.noir;
in {
  imports = [
    ./hyprland.nix
    ./scripts.nix
    ./binds.nix
    ./rules.nix
  ];

  options.desktop.environments.noir = {
    enable = lib.mkEnableOption "Enable hyprland desktop with sane defaults";
  };

  config = lib.mkIf cfg.enable {
    desktop = {
      programs = {
        fuzzel.enable = true;
        hyprlock.enable = true;
        nautilus.enable = true;
        waybar.enable = true;
        feh.enable = true;
        mpv.enable = true;
      };
      services = {
        gammastep.enable = true;
        gnome-keyring.enable = true;
        hypridle.enable = true;
        mako.enable = true;
      };
    };

    stylix.targets.hyprpaper.enable = lib.mkForce false;

    home.file = {
      "Pictures/Wallpapers".source = ../../../../../assets/wallpapers;
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
  };
}

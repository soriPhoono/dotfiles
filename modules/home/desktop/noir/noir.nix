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
        ghostty.enable = true;
        hyprlock.enable = true;
        mako.enable = true;
        nautilus.enable = true;
        waybar.enable = true;
      };
      services = {
        gammastep.enable = true;
        gnome-keyring.enable = true;
        hypridle.enable = true;
      };
    };

    stylix.targets.hyprland.hyprpaper.enable = false;

    home.file = {
      "Pictures/Wallpapers".source = ../../../../assets/wallpapers;
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

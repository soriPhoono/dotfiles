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
    ./hyprland/monitors.nix
    ./hyprland/rules.nix

    ./programs/mako.nix
    ./programs/fuzzel.nix
    ./programs/waybar.nix
    ./programs/wlogout.nix
    ./programs/hyprlock.nix
    ./programs/kitty.nix
    ./programs/nautilus.nix
    ./programs/firefox.nix

    ./services/gammastep.nix
    ./services/hypridle.nix
  ];

  options.desktop.noir = {
    enable = lib.mkEnableOption "Enable hyprland desktop with sane defaults";
  };

  config = lib.mkIf cfg.enable {
    stylix.targets.hyprland.hyprpaper.enable = false;

    gtk.iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    wayland.windowManager.hyprland = {
      enable = true;

      systemd.variables = ["--all"];
    };

    services.gnome-keyring.enable = true;
  };
}

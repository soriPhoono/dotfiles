{
  lib,
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
    ./programs/kitty.nix
    ./programs/firefox.nix
  ];

  options.desktop.noir = {
    enable = lib.mkEnableOption "Enable hyprland desktop with sane defaults";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      systemd.variables = ["--all"];
    };

    services.gnome-keyring.enable = true;
  };
}

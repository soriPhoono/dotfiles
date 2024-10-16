{ lib, pkgs, config, ... }:
let cfg = config.desktop.hyprland;
in {
  options = {
    desktop.hyprland.enable = lib.mkEnableOption "Enable desktop support";
  };

  config = lib.mkIf cfg.enable {
    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];

      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };

    xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];

    security.polkit.enable = true;

    environment.systemPackages = with pkgs; [
      playerctl
    ];

    programs = {
      hyprland.enable = true;

      gnome-disks.enable = true;
      file-roller.enable = true;
    };

    services = {
      upower.enable = true;

      gvfs.enable = true;
      udisks2.enable = true;
    };

    desktop.enable = true;
    desktop.boot.enable = true;
    desktop.regreet.enable = true;
  };
}

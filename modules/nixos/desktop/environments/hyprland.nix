{ lib, pkgs, config, username, ... }:
let cfg = config.desktop.environments.hyprland;
in
{
  options = {
    desktop.environments.hyprland.enable = lib.mkEnableOption "Enable desktop support";
  };

  config = lib.mkIf cfg.enable {
    desktop = {
      boot.enable = true;

      services = {
        sddm.enable = true;

        pipewire.enable = true;
      };
    };

    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];

      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };

    security.polkit.enable = true;

    xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];

    programs.hyprland.enable = true;

    services.gvfs.enable = true;

    networking.networkmanager.enable = true;

    users.users.${username}.extraGroups = [ "networkmanager" ];
  };
}

{ inputs, lib, pkgs, config, ... }:
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

    desktop = {
      enable = true;
      boot.enable = true;
    };

    xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];

    programs = {
      hyprland = {
        enable = true;
        package =
          inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      };

      hyprlock.enable = true;
    };

    services.hypridle.enable = true;

    security.polkit.enable = true;
  };
}

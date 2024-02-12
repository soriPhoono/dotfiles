{ pkgs, ... }: {
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      configPackages = pkgs.xdg-desktop-portal-hyprland;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
}

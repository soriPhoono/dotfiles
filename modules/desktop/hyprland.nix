{ pkgs, ... }: {
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
      config = {
        common = {
          default = [
            "gtk"
            "hyprland"
          ];
        }; # TODO: check this configuration for validity
      };
    };
  };

  programs = {
    xwayland = {
      enable = true;
    };

    hyprland = {
      enable = true;
    };
  };
}

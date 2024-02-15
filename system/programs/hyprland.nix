{ inputs, pkgs, ... }: {
  imports = [
    inputs.hyprland.nixosModules.default;
  ];

  xdg = {
    portal = {
      enable = true;

      xdgOpenUsePortal = true;

      config = {
        common = {
          default = [
            "gtk"
          ];
        };
        hyprland = {
          default = [
            "hyprland"
          ];
        };
      };

      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
  };

  environment.variables.NIXOS_OZONE_WL = "1";

  programs.hyprland.enable = true;
}

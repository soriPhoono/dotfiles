{ vars, ... }: {
  imports = [
    ../modules/home-manager/core

    ../modules/home-manager/programs
    ../modules/home-manager/services

    ../modules/home-manager/desktops/hyprland.nix

    ../modules/home-manager/themes/catppuccin.nix
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "${vars.stateVersion}";
}

{ inputs, pkgs, vars, ... }: {
  imports = [
    inputs.ags.homeManagerModules.default

    ../modules/home-manager/core

    ../modules/home-manager/programs
    ../modules/home-manager/services

    ../modules/home-manager/desktops/hyprland.nix

    ../modules/home-manager/themes/catppuccin.nix
  ];

  home.packages = with pkgs; [
    # Applications
    gnome.nautilus
    gnome.file-roller
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "${vars.stateVersion}";
}

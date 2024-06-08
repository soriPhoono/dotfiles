{ inputs, pkgs, vars, ... }: {
  imports = [
    inputs.ags.homeManagerModule.default

    ../modules/home-manager/core/xdg.nix

    ../modules/home-manager/programs
    ../modules/home-manager/services

    ../modules/home-manager/themes/catppuccin.nix
  ];

  home.packages = with pkgs; [
    # Core development packages
    gitkraken

    # Applications
    font-manager
    gnome.nautilus
    gnome.file-roller
    gnome.gnome-disk-utility
    gparted
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "${vars.stateVersion}";
}

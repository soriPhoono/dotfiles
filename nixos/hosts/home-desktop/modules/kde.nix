{ inputs, pkgs, ... }: {
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager

    ../../../../modules/home-manager/core/xdg.nix
    ../../../../modules/home-manager/core/utility-progs.nix

    ../../../../modules/home-manager/programs/cli.nix
    ../../../../modules/home-manager/programs/git.nix
    ../../../../modules/home-manager/programs/development.nix
    ../../../../modules/home-manager/programs/gaming.nix
    ../../../../modules/home-manager/programs/streaming.nix
    ../../../../modules/home-manager/programs/utilities.nix

    ../../../../modules/home-manager/services/mpris-proxy.nix

    ../../../../modules/home-manager/kde
    ../../../../modules/home-manager/hyprland
  ];

  home.packages = with pkgs; [
    blender
  ];
}

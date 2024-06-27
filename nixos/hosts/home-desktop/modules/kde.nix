{ inputs, pkgs, ... }: {
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager

    ../../../modules/home-manager/core
    ../../../modules/home-manager/development
    ../../../modules/home-manager/programs

    ../../../modules/home-manager/services/mpris-proxy.nix

    ../../../modules/home-manager/kde
  ];

  home.packages = with pkgs; [
    intel-gpu-tools

    blender-hip
  ];
}

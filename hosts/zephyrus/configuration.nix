{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/boot
    ../../modules/nixos/core

    ../../modules/nixos/hardware/opengl.nix

    ../../modules/nixos/services/fprintd.nix
    ../../modules/nixos/services/openssh.nix
    ../../modules/nixos/services/pipewire.nix
    ../../modules/nixos/services/zram-generator.nix

    ../../modules/nixos/desktops/hyprland.nix
  ];

  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=suspend
  '';

  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;

  system.stateVersion = "24.05";
}
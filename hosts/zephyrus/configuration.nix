{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/boot

    ../../modules/nixos/core/core.nix
    ../../modules/nixos/core/file-system.nix
    ../../modules/nixos/core/localization.nix
    ../../modules/nixos/core/networkmanager.nix

    
  ];

  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=suspend
  '';

  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;

  system.stateVersion = "24.05";
}
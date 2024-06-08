{ ... }: {
  imports = [
    ./file-system.nix
    ./localization.nix
    ./network-manager.nix
  ];

  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=suspend
  ''
}
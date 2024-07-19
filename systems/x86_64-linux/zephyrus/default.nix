{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.enable = true;
  hardware.nvidia.open = true;

  cli.enable = true;

  bluetooth.enable = true;
  opengl.enable = true;
  logitech.enable = true;
  xbox.enable = true;
  qmk.enable = true;

  networking.networkManager.enable = true;

  hyprland.enable = true;

  programs.gaming.enable = true;
  services.openrgb.enable = true;

  services.logind.extraConfig = ''
    HandlePowerKey=poweroff
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=suspend
  '';
}

{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.enable = true;

  hardware = {
    nvidia.open = true;
  };

  bluetooth.enable = true;
  opengl.enable = true;
  logitech.enable = true;
  xbox.enable = true;
  qmk.enable = true;

  core.cli.enable = true;
  networking.networkManager.enable = true;
  programs.enable = true;
  programs.gaming.enable = true;
  services.openrgb.enable = true;
  pipewire.enable = true;

  kde.enable = true;

  services.logind.extraConfig = ''
    HandlePowerKey=poweroff
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=suspend
  '';

  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;
}

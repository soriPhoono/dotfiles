{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  hardware = {
    nvidia.open = true;

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  boot.enable = true;
  networking.networkManager.enable = true;
  bluetooth.enable = true;

  services.logind.extraConfig = ''
    HandlePowerKey=poweroff
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=suspend
  '';

  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;
}

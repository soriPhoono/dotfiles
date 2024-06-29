{ pkgs, ... }: {
  hardware.xpadneo.enable = true;

  environment.systemPackages = with pkgs; [
    xboxdrv
  ];

  boot.extraModprobeConfig = '' options bluetooth disable_ertm=1 '';
}

{ config, ... }: {
  hardware.xpadneo.enable = true;

  boot = {
    extraModprobeConfig = '' options bluetooth disable_ertm=1 '';

    extraModulePackages = with config.boot.kernelPackages; [ xpadneo ];
    kernelModules = [ "hid_xpadneo" ];
  };
}

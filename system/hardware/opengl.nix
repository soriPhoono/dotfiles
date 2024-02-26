{ config, pkgs, ... }: {
  hardware.opengl = {
    enable = true;

    driSupport32Bit = true;

    extraPackages = with pkgs; [
      opencl-info
    ];

    extraPackages32 = with pkgs; [

    ];
  };
}

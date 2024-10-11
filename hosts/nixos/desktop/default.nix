{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix

    ../configuration.nix
  ];

  desktop = {
    boot.enable = true;
    regreet.enable = true;
    hyprland.enable = true;
    thunar.enable = true;
    steam.enable = true;
  };

  boot.kernelParams = [ "i915.force_probe=a780" ];

  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    libvdpau-va-gl
  ];
}

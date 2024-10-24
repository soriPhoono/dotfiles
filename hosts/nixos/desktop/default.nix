{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix

    ../configuration.nix
  ];

  desktop = {
    environments.kde.enable = true;

    programs = {
      openrgb.enable = true;
      steam.enable = true;
    };
  };

  boot.kernelParams = [ "i915.force_probe=a780" ];

  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    libvdpau-va-gl

    rocmPackages.clr.icd
  ];

  systemd.tmpfiles.rules =
    [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
}

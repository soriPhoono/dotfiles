{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix

    ../configuration.nix
  ];

  core = {
    boot.kernelParams = [
      "i915.force_probe=a780"
    ];

    hardware.graphics = {
      enable = true;

      extraPackages = with pkgs; [
        intel-media-driver
        libvdpau-va-gl

        rocmPackages.clr.icd
      ];
    };

    environmentVariables = {
      KWIN_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card2";

      LIBVA_DRIVER_NAME = "iHD";
    };
  };

  desktop = {
    environments.kde.enable = true;

    programs.steam.enable = true;
  };

  systemd.tmpfiles.rules =
    [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
}

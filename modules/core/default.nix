{
  imports = [
    ./systemd-boot.nix
    ./plymouth.nix

    ./
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    kernelParams = [
      "i915.force_probe=a780"
    ];
  };
}

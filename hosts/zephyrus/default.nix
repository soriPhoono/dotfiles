{ inputs, ... }: {
  imports = with inputs; [
    ./hardware-configuration.nix

    nixos-hardware.nixosModules.asus-zephyrus-ga401
  ];

  core = {
    hardware.enable = true;
    openssh.enable = true;
  };

  desktop = {
    boot.enable = true;
    dm.regreet.enable = true;
    wm.hyprland.enable = true;

    programs.libvirtd.enable = true;
  };

  laptop.droidcam.enable = true;
}

{ inputs, ... }: {
  imports = with inputs; [
    ./hardware-configuration.nix

    ../configuration.nix

    nixos-hardware.nixosModules.asus-zephyrus-ga401
  ];

  desktop = {
    boot.enable = true;
    hyprland.enable = true;
    openrgb.enable = true;
    steam.enable = true;
    droidcam.enable = true;
  };
}

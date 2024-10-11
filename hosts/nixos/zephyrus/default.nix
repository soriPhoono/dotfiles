{ inputs, ... }: {
  imports = with inputs; [
    ./hardware-configuration.nix

    ../configuration.nix

    nixos-hardware.nixosModules.asus-zephyrus-ga401
  ];

  desktop = {
    boot.enable = true;
    regreet.enable = true;
    hyprland.enable = true;
    thunar.enable = true;
    steam.enable = true;
  };

  laptop.droidcam.enable = true;
}

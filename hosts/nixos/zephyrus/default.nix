{ inputs, ... }: {
  imports = with inputs; [
    ./hardware-configuration.nix

    ../configuration.nix

    nixos-hardware.nixosModules.asus-zephyrus-ga401
  ];

  desktop = {
    hyprland.enable = true;
    steam.enable = true;
    droidcam.enable = true;
  };

  services.upower.enable = true;
}

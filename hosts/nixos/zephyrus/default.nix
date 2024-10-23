{ inputs, ... }: {
  imports = with inputs; [
    ./hardware-configuration.nix

    ../configuration.nix

    nixos-hardware.nixosModules.asus-zephyrus-ga401
  ];

  desktop = {
    environments.kde.enable = true;

    programs = {
      openrgb.enable = true;
      droidcam.enable = true;
      steam.enable = true;
    };
  };
}

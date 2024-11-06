{ inputs, ... }: {
  imports = with inputs; [
    ./hardware-configuration.nix

    ../configuration.nix

    nixos-hardware.nixosModules.asus-zephyrus-ga401
  ];

  core.hardware.graphics.enable = true;

  desktop = {
    environments.kde.enable = true;

    programs = {
      steam.enable = true;

      supporting = {
        partition-manager = true;
        droidcam = true;
      };
    };
  };
}

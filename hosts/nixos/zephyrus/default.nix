{ inputs, ... }:
{
  imports = with inputs; [
    ./hardware-configuration.nix

    ../configuration.nix

    nixos-hardware.nixosModules.asus-zephyrus-ga401
  ];

  desktop = {
    hyprland = {
      enable = true;

      monitors = [
        "eDP-1, 1920x1080@144, 0x0, 1"
      ];
    };

    steam = {
      enable = true;

      session = {
        enable = true;

        output = "eDP-1";

        resolution = {
          width = 1920;
          height = 1080;
          refreshRate = 144;
        };
      };
    };
  };
}

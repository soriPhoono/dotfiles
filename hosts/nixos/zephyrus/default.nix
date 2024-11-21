{ inputs, ... }:
{
  imports = with inputs; [
    ./hardware-configuration.nix

    ../configuration.nix

    nixos-hardware.nixosModules.asus-zephyrus-ga401
  ];

  core.environment.variables = {
    AQ_DRM_DEVICES = "/dev/dri/card0:/dev/dri/card1";
  };

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
      };
    };
  };
}

{ inputs, pkgs, ... }:
{
  imports = with inputs; [
    ./hardware-configuration.nix

    ../configuration.nix

    nixos-hardware.nixosModules.asus-zephyrus-ga401
  ];

  users.users.soriphoono = {
    description = "Sori Phoono";

    isNormalUser = true;
    shell = pkgs.fish;

    extraGroups = [ "wheel" ];
  };

  core.hardware.graphics.enable = true;

  desktop = {
    environments.kde.enable = true;

    programs = {
      steam.enable = true;

      supporting = {

        droidcam = true;
      };
    };
  };
}

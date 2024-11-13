{ inputs, lib, pkgs, ... }:
let
  mkUser = username: isWheel: {
    description = "${username}";

    isNormalUser = true;
    shell = pkgs.fish;

    extraGroups = lib.mkIf isWheel [ "wheel" ];
  };
in
{
  imports = with inputs; [
    ./hardware-configuration.nix

    ../configuration.nix

    nixos-hardware.nixosModules.asus-zephyrus-ga401
  ];

  users.users.soriphoono = mkUser "Sori Phoono" true;

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

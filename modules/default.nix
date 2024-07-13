{ lib, inputs, pkgs, ... }: {
  imports = [
    inputs.nix-index-db.nixosModules.nix-index

    ./core/nixpkgs.nix
    ./core/boot.nix
    ./core/localization.nix
    ./core/users.nix
    ./core/networking.nix

    ./programs/utilities.nix

    ./services/openssh.nix
  ];

  documentation.dev.enable = true;

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    coreutils

    wget
  ];

  programs.nix-index-database.comma.enable = true;

  system.stateVersion = lib.mkDefault "24.11";
}

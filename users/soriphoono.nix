{ lib, pkgs, ... }: {
  imports = [
    ./common

    ./common/themes/catppuccin.nix
  ];

  programs = {
    home-manager.enable = true;
  };

  home.stateVersion = lib.mkDefault "24.11";
}

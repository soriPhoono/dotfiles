{ config, pkgs, ... }: {
  imports = [
    ./regreet.nix
  ];

  programs.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
  };
}

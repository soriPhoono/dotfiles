{ lib, pkgs, config, ... }:
let cfg = config.desktop.programs;
in {
  imports = [
    ./alacritty.nix
    ./firefox.nix
    ./fuzzel.nix
    ./hyprlock.nix
    ./waybar.nix
    ./wlogout.nix
  ];

  options = {
    desktop.programs.enable =
      lib.mkEnableOption "Enable basic desktop programs";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        gnome-disk-utility

        obsidian

        discord
      ];
    };
  };
}

{ lib, pkgs, config, ... }:
let cfg = config.desktop.programs;
in {
  imports = [
    ./ags.nix
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
        # CLI apps
        nvtopPackages.full

        # Desktop system level apps
        gnome-disk-utility

        # Desktop user level apps
        # Office work
        obsidian
        # Communications
        discord
      ];
    };
  };
}
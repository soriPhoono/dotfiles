{ lib, pkgs, config, ... }:
let cfg = config.desktop.programs;
in {
  imports = [
    ./ags.nix
    ./alacritty.nix
    ./firefox.nix
    ./fuzzel.nix
    ./hyprlock.nix
    ./wlogout.nix
  ];

  options = {
    desktop.programs.enable =
      lib.mkEnableOption "Enable basic desktop programs";
  };

  config = lib.mkIf cfg.enable {
    home = {
      shellAliases = with pkgs; {
        nvtop = "${nvtopPackages.full}/bin/nvtop";
      };

      packages = with pkgs; [
        # Desktop system level apps
        gnome-disk-utility
      ];
    };
  };
}

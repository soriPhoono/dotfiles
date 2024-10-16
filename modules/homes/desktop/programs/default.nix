{ lib, pkgs, config, ... }:
let cfg = config.desktop.programs;
in {
  imports = [
    ./ags.nix
    ./alacritty.nix
    ./fuzzel.nix
    ./wlogout.nix
  ];

  options = {
    desktop.programs.enable =
      lib.mkEnableOption "Enable basic desktop programs";
  };

  config = lib.mkIf cfg.enable {
    home = {
      shellAliases = with pkgs; { nvtop = "${nvtopPackages.full}/bin/nvtop"; };
    };

    programs = {
      feh.enable = true;
      mpv.enable = true;
    };
  };
}

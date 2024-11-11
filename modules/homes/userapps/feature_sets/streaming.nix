{ lib, pkgs, config, ... }:
let cfg = config.userapps.streaming;
in {
  options = {
    userapps.streaming = lib.mkEnableOption "Enable streaming userlevel applications";
  };

  config = lib.mkIf cfg {
    home.packages = with pkgs; [
      gimp
      audacity
      davinci-resolve
    ];

    userapps.programs.obs-studio.enable = true;
  };
}

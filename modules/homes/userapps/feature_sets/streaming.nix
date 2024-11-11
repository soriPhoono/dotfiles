{ lib, pkgs, config, ... }:
let cfg = config.userapps.feature_sets;
in {
  options = {
    userapps.feature_sets.streaming = lib.mkEnableOption "Enable streaming userlevel applications";
  };

  config = lib.mkIf cfg.streaming {
    home.packages = with pkgs; [
      gimp
      audacity
      davinci-resolve
    ];

    userapps.programs.obs-studio.enable = true;
  };
}

{ lib, pkgs, config, ... }:
let cfg = config.userapps.feature_sets;
in {
  options = {
    userapps.feature_sets.artwork = lib.mkEnableOption "Enable artwork tools in user profile";
  };

  config = lib.mkIf cfg.artwork {
    home.packages = with pkgs; [
      krita
    ];
  };
}
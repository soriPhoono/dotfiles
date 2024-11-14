{ lib, pkgs, config, ... }:
let cfg = config.userapps.feature_sets.gaming;
in {
  options = {
    userapps.feature_sets.gaming = {
      enable = lib.mkEnableOption "Enable gaming programs";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (prismlauncher.override {
        jdks = [
          zulu8
          zulu
        ];
      })

      path-of-building
    ];
  };
}

{ lib, pkgs, config, ... }:
let cfg = config.userapps.feature_sets;
in {
  options = {
    userapps.feature_sets.gaming = lib.mkEnableOption "Enable gaming programs";
  };

  config = lib.mkIf cfg.gaming {
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

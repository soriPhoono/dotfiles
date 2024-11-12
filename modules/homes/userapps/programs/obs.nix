{ lib, pkgs, config, ... }:
let cfg = config.userapps.programs.obs-studio;
in {
  options = {
    userapps.programs.obs-studio.enable = lib.mkEnableOption "Enable obs studio";
  };

  config = lib.mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;

      plugins = with pkgs.obs-studio-plugins; [
        obs-vkcapture
        obs-vaapi
      ];
    };
  };
}

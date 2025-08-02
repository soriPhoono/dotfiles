{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.features.streaming;
in {
  options.userapps.features.streaming = {
    enable = lib.mkEnableOption "Enable streaming tools";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      easyeffects
      
      davinci-resolve
    ];

    programs = {
      obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          input-overlay
          obs-vkcapture
        ];
      };
    };
  };
}

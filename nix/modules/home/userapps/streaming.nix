{ lib, pkgs, config, ...}:
let cfg = config.userapps.streaming;
in {
  options.userapps.streaming = lib.mkEnableOption "Enable streaming services";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gimp
      audacity
      davinci-resolve
    ];

    programs.obs-studio = {
      enable = true;

      plugins = with pkgs.obs-studio-plugins; [
        obs-vkcapture
        obs-vaapi
      ];
    };
  };
}

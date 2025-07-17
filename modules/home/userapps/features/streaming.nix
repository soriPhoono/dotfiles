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
      obs-studio
      gimp
      tenacity
      davinci-resolve
    ];
  };
}

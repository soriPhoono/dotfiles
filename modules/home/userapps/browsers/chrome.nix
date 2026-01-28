{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.browsers.chrome;
in {
  options.userapps.browsers.chrome = {
    enable = lib.mkEnableOption "Enable Google Chrome";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      google-chrome
    ];
  };
}

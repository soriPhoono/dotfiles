{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.streaming;
in {
  options.userapps.streaming.enable = lib.mkEnableOption "Enable streaming applications";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      obs-studio

      gimp
      tenacity
      kdePackages.kdenlive
    ];
  };
}

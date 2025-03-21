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
      gimp
      tenacity
      kdePackages.kdenlive
    ];

    userapps.programs.obs-studio.enable = true;
  };
}

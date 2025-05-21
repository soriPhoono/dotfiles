{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.features.development;
in {
  options.userapps.features.development.enable = lib.mkEnableOption "Enable software development features";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      obsidian
    ];
  };
}

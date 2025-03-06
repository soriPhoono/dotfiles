{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.programs.ghostty;
in {
  options.desktop.programs.ghostty.enable = lib.mkEnableOption "Enable ghostty terminal";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      ghostty
    ];
  };
}

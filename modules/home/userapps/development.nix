{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.development;
in {
  options.userapps.development.enable = lib.mkEnableOption "Enable development software";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      element-desktop

      android-udev-rules
      android-tools
    ];
  };
}

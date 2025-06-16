{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.services.quickshare;
in {
  options.desktop.services.quickshare.enable = lib.mkEnableOption "Enable quickshare for android devices";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      rquickshare
    ];
  };
}

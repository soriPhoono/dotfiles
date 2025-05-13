{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.hardware.hid.qmk;
in {
  options.core.hardware.hid.qmk.enable = lib.mkEnableOption "Enable QMK userspace drivers";

  config = lib.mkIf cfg.enable {
    hardware.keyboard.qmk.enable = true;

    environment.systemPackages = with pkgs; [
      via
    ];
    services.udev.packages = [pkgs.via];
  };
}

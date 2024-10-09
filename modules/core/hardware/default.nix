{ lib, config, ... }:
let cfg = config.core.hardware;
in {
  imports =
    [ ./bluetooth.nix ./logitech.nix ./xbox.nix ];

  options = {
    core.hardware.enable = lib.mkEnableOption "Enable all hardware modules";
  };

  config = lib.mkIf cfg.enable {
    core.hardware = {
      bluetooth.enable = lib.mkDefault true;
      logitech.enable = lib.mkDefault true;
      xbox_controller.enable = lib.mkDefault true;
    };
  };
}

{ lib, pkgs, config, ... }:
let
  this = "system.hardware.bluetooth";

  cfg = config."${this}";
in
{
  options."${this}" = {
    enable = lib.mkEnableOption "Enable bluetooth support on this system";
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };
  };
}

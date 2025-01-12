{ lib, config, ... }:
let
  this = "system.hardware.monitor";

  cfg = config."${this}";
in
{
  options."${this}" = {
    enable = lib.mkEnableOption "Enable monitor brightness controls";
  };

  config = lib.mkIf cfg.enable {
    hardware.brillo.enable = true;
  };
}

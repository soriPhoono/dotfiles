{ lib, config, ... }:
let
  this = "system.brightness";

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

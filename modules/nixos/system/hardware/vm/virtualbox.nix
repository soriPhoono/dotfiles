{ lib, config, ... }:
let
  this = "system.hardware.vm.virtualbox";

  cfg = config."${this}";
in
{
  options."${this}".enable = lib.mkEnableOption "Create virtualbox host";

  config = lib.mkIf cfg.enable {
    system.hardware.vm.enable = true;

    virtualisation.virtualbox.guest.enable = true;
  };
}

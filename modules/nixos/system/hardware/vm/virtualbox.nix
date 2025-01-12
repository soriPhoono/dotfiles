{ lib, pkgs, config, ... }:
let
  this = "system.hardware.vm.virtualbox";

  cfg = config."${this}";
in
{
  options."${this}".enable = lib.mkEnableOption "Enable virtualbox guest additions";

  config = lib.mkIf cfg.enable {
    virtualisation.virtualbox.guest.enable = true;
  };
}

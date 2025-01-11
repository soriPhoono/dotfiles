{ lib, config, ... }:
let
  cfg = config.system.vm.virtualbox;
in
{
  options.system.vm.virtualbox.enable = lib.mkEnableOption "Create virtualbox host";

  config = lib.mkIf cfg.enable {
    system.vm.enable = true;

    virtualisation.virtualbox.guest.enable = true;
  };
}

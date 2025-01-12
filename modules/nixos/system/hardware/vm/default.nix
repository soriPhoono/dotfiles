{ lib, config, ...}:
let
  this = "system.hardware.vm";

  cfg = config."${this}";
in {
  imports = [
    ./virtualbox.nix
  ];

  options."${this}".enable = lib.mkEnableOption "Enable core support for vm systems";
}

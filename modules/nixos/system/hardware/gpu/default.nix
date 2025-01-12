{ lib, pkgs, config, ... }:
let
  this = "system.hardware.gpu";

  cfg = config."${this}";
in
{
  imports = [
    ./intel.nix
    ./amd.nix
  ];

  options."${this}" = {
    enable = lib.mkEnableOption "Enable gpu based features";
  };

  config = lib.mkIf (cfg.enable && !config.system.hardware.vm.enable) {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    environment.systemPackages = with pkgs; [
      nvtopPackages.full
    ];
  };
}

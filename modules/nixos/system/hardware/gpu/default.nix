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

  config = lib.mkIf cfg.enable {
    warnings =
      if config.system.vm.enable
      then [
        ''You have enabled virtualisation features on a platform you have requested be built for real hardware, please disable one as they conflict.''
      ] else [ ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    environment.systemPackages = with pkgs; [
      nvtopPackages.full
    ];
  };
}

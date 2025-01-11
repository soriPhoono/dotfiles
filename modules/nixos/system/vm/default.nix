{ lib, config, ...}: let
  cfg = config.system.vm;
in {
  imports = [
    ./virtualbox.nix
  ];

  options.system.vm.enable = lib.mkEnableOption "Enable core support for vm systems";

  config = lib.mkIf cfg.enable {
    warnings =
      if config.system.hardware.Enable
      then [
        ''You have enabled real hardware features on a platform you have requested be built for virtualisation, please disable one as they conflict.''
      ]
      else [];
  };
}

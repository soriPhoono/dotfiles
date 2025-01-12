{ lib, config, ...}:
let
  this = "system.hardware.vm";

  cfg = config."${this}";
in {
  imports = [
    ./virtualbox.nix
  ];

  options."${this}".enable = lib.mkEnableOption "Enable core support for vm systems";

  config = lib.mkIf cfg.enable {
    warnings =
      if config.system.hardware.enable
      then [
        ''You have enabled real hardware features on a platform you have requested be built for virtualisation, please disable one as they conflict.''
      ]
      else [];
  };
}

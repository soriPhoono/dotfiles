{ lib, config, ... }:
let cfg = config.cli.hardware.graphics;
in {
  options.cli.hardware.graphics = {
    enable = lib.mkEnableOption "Enable graphics support";

    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      description = "Extra packages to install for graphics support";
    };
  };

  config.hardware.graphics = lib.mkIf cfg.enable {
    enable = true;
    enable32Bit = true;

    extraPackages = cfg.extraPackages;
    extraPackages32 = cfg.extraPackages;
  };
}

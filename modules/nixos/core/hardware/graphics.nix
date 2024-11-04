{ lib, config, ... }:
let
  cfg = config.core.hardware.graphics;
in
{
  options = {
    core.hardware.graphics = {
      enable = lib.mkEnableOption "Enable graphical support";

      extraPackages = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        default = [ ];
      };

      extraPackages32 = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        default = [ ];
      };
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;

      extraPackages = cfg.extraPackages;
      extraPackages32 = cfg.extraPackages32;
    };
  };
}

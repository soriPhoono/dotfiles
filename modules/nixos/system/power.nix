{ lib, config, ... }:
let
  this = "system.power";

  cfg = config."${this}";
in
{
  options."${this}" = {
    enable = lib.mkEnableOption "Enable power optimisations";
  };

  config = lib.mkIf cfg.enable {
    warnings = [ ];

    services.tlp = {
      enable = true;

      settings = {
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVENOR_ON_AC = "performance";
        CPU_SCALING_GOVENOR_ON_BAT = "powersave";
      };
    };

    powerManagement.powertop.enable = true;
  };
}

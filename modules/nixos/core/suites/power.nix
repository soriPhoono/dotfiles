{
  lib,
  config,
  ...
}: let
  cfg = config.core.suites.power;
in {
  options.core.suites.power = {
    enable = lib.mkEnableOption "Enable power optimisations";
  };

  config = lib.mkIf cfg.enable {
    services = {
      upower.enable = true;

      tlp = {
        enable = true;

        settings = {
          CPU_BOOST_ON_AC = 1;
          CPU_BOOST_ON_BAT = 0;
          CPU_SCALING_GOVENOR_ON_AC = "performance";
          CPU_SCALING_GOVENOR_ON_BAT = "powersave";
        };
      };
    };
  };
}

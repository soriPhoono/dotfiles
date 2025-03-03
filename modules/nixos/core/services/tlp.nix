{
  lib,
  config,
  ...
}: let
  cfg = config.core.services.tlp;
in {
  options.core.services.tlp = {
    enable =
      lib.mkEnableOption "Enable power optimisations"
      // {
        default = true;
      };
  };

  config = lib.mkIf cfg.enable {
    services = {
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

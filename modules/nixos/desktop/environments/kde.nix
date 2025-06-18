{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.environments.kde;
in {
  options.desktop.environments.kde = {
    enable = lib.mkEnableOption "Enable kde desktop environment";
  };

  config = lib.mkIf cfg.enable {
    environment = {
      sessionVariables.NIXOS_OZONE_WL = "1";
    };

    services = {
      displayManager = {
        sddm = {
          enable = true;
          wayland = {
            enable = true;
            compositor = "kwin";
          };
        };
      };
      desktopManager.plasma6.enable = true;
    };
  };
}

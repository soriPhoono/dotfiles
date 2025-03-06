{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.services.gammastep;
in {
  options.desktop.services.gammastep.enable = lib.mkEnableOption "Enable gammastep color management daemon";

  config = lib.mkIf cfg.enable {
    services.gammastep = {
      enable = true;

      provider = "geoclue2";

      settings.general.adjustment-method = "wayland";
    };
  };
}

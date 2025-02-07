{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  config = lib.mkIf cfg.enable {
    services.gammastep = {
      enable = true;

      provider = "geoclue2";

      settings.general.adjustment-method = "wayland";
    };
  };
}

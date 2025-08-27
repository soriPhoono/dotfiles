{
  lib,
  config,
  ...
}: let cfg = config.desktop.services.openrazer;
in {
  options.desktop.services.openrazer = {
    enable = lib.mkEnableOption "OpenRazer service for Razer devices";
  };

  config = lib.mkIf cfg.enable {
    hardware.openrazer.enable = true;

    users.extraUsers =
      builtins.mapAttrs (_: _: {
        extraGroups = [
          "openrazer"
        ];
      })
      config.core.users;
  };
}
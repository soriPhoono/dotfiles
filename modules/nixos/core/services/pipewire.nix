{
  lib,
  config,
  ...
}: let
  cfg = config.core.services.pipewire;
in {
  options.core.services.pipewire.enable = lib.mkEnableOption "Enable audio driver";

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;

      alsa.enable = true;
      alsa.support32Bit = true;

      pulse.enable = true;
    };
  };
}

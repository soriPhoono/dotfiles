{
  lib,
  config,
  ...
}: let
  cfg = config.core.audio;
in {
  options.core.audio.enable = lib.mkEnableOption "Enable audio driver";

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

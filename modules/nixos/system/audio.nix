{
  lib,
  config,
  ...
}: let
  cfg = config.system.pipewire;
in {
  options.system.pipewire.enable = lib.mkEnableOption "Enable audio driver";

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;

      alsa.enable = true;
      alsa.support32Bit = true;

      jack.enable = true;

      pulse.enable = true;
    };
  };
}

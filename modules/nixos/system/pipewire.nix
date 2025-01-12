{ lib, config, ... }:
let
  this = "system.pipewire";

  cfg = config."${this}";
in
{
  options."${this}".enable = lib.mkEnableOption "Enable audio driver";

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

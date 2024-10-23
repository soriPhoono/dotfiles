{ lib, config, ... }:
let cfg = config.desktop.services.pipewire;
in {
  options = {
    desktop.services.pipewire = {
      enable = lib.mkEnableOption "Enable pipewire";
    };
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;

      jack.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}


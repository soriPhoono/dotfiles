{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.services.pipewire;
in
  with lib; {
    options.desktop.services.pipewire = {
      enable = mkEnableOption "Enable PipeWire audio and video service";
    };

    config = lib.mkIf cfg.enable {
      services.pipewire = {
        enable = true;
        pulse.enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        jack.enable = true;
      };
    };
  }

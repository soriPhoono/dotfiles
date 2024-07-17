{ lib, config }:
let cfg = config.services.pipewire;
in {
  options = {
    pipewire.enable = lib.mkEnableOption "Enable PipeWire";
  };

  config = lib.mkIf cfg.enable {
    services = {
      pipewire = {
        enable = true;

        pulse.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        jack.enable = true;

        wireplumber.enable = true;
      };
    };

    users.users.soriphoono.extraGroups = [
      "audio"
    ];
  };
}

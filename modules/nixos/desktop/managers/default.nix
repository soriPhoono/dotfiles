{ lib, config, ... }:
let cfg = config.desktop.managers;
in {
  options = {
    desktop.managers = {
      pipewire.enable = lib.mkEnableOption "Enable Pipewire support";
      sddm.enable = lib.mkEnableOption "Enable SDDM support";
    };
  };

  config = {
    services = {
      pipewire = lib.mkIf cfg.pipewire.enable {
        enable = true;

        pulse.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        jack.enable = true;
      };

      displayManager.sddm = lib.mkIf cfg.sddm.enable {
        enable = true;

        wayland.enable = true;
      };
    };

    users.users.soriphoono.extraGroups = lib.mkIf cfg.pipewire.enable [
      "audio"
    ];
  };
}

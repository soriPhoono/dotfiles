{ lib, config, ... }:
let cfg = config.desktop.environments.pipewire;
in {
  options = {
    desktop.environments.pipewire.enable = lib.mkEnableOption "Enable Pipewire support";
  };

  config = lib.mkIf cfg.enable {
    core.hardware.bluetooth.enable = true;

    services.pipewire = {
      enable = true;

      audio.enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;

      wireplumber = {
        enable = true;

        extraConfig = {
          "monitor.bluez.properties" = {
            "bluez5.enable-sbc-xq" = true;
            "bluez5.enable-msbc" = true;
            "bluez5.enable-hw-volume" = true;
            "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
          };
        };
      };
    };
  };
}

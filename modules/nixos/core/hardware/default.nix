{ lib, config, ... }:
let cfg = config.core.hardware;
in {
  options = {
    core.hardware = {
      bluetooth.enable = lib.mkEnableOption "Enable Bluetooth support";
      logitech.enable = lib.mkEnableOption "Enable Logitech support";
      opengl.enable = lib.mkEnableOption "Enable OpenGL support";
      qmk.enable = lib.mkEnableOption "Enable QMK support";
      xbox.enable = lib.mkEnableOption "Enable Xbox support";
    };
  };

  config = {
    hardware = {
      bluetooth = lib.mkIf cfg.bluetooth.enable {
        enable = true;
        powerOnBoot = true;

        settings = {
          General = {
            Experimental = true;

            Enable = "Source,Sink,Media,Socket";
          };
        };
      };

      logitech.wireless = lib.mkIf cfg.logitech.enable {
        enable = true;
        enableGraphical = true;
      };

      graphics = lib.mkIf cfg.opengl.enable {
        enable = true;
        enable32Bit = true;
      };

      keyboard.qmk.enable = cfg.qmk.enable;

      xone.enable = cfg.xbox.enable;
      steam-hardware.enable = cfg.xbox.enable;
      uinput.enable = cfg.xbox.enable;
    };

    services.pipewire.wireplumber.extraConfig = lib.mkIf cfg.bluetooth.enable {
      "monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = true;
        "bluez5.enable-msbc" = true;
        "bluez5.enable-hw-volume" = true;
        "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
      };
    };
  };
}

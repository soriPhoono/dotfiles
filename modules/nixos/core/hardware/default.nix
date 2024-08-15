{ lib, config, ... }:
let cfg = config.core.hardware;
in {
  options = {
    core.hardware = {
      bluetooth.enable = lib.mkEnableOption "Enable Bluetooth support";
      graphics.enable = lib.mkEnableOption "Enable OpenGL support";
      logitech.enable = lib.mkEnableOption "Enable logitech mice support";
      qmk.enable = lib.mkEnableOption "Enable Qmk userspace support";
      xbox.enable = lib.mkEnableOption "Enable Xbox controller support";
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

      graphics = lib.mkIf cfg.graphics.enable {
        enable = true;
        enable32Bit = true;
      };

      logitech.wireless = lib.mkIf cfg.logitech.enable {
        enable = true;
        enableGraphical = true;
      };

      keyboard.qmk.enable = lib.mkIf cfg.qmk.enable true;

      xone.enable = lib.mkIf cfg.xbox.enable true;
      steam-hardware.enable = lib.mkIf cfg.xbox.enable true;
      uinput.enable = lib.mkIf cfg.xbox.enable true;
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

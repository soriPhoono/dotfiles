{ lib, config, ... }:
let cfg = config.desktop.services.hypridle;
in {
  options = {
    desktop.services.hypridle.enable = lib.mkEnableOption "Enable hypridle";
  };

  config = lib.mkIf cfg.enable {
    desktop.programs.util.hyprlock.enable = true;

    services.hypridle = {
      enable = true;

      settings = {
        general = {
          ignore_dbus_inhibit = false;
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
          {
            timeout = 150;
            on-timeout = "brightnessctl -s set 10 && brightnessctl -sd asus:kbd_backlight set 0";
            on-resume = "brightnessctl -r && brightnessctl -rd asus:kbd_backlight";
          }
          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 450;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 600;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
}

{ lib, config, ... }:
let cfg = config.desktops.services.hypridle;
in {
  options = {
    desktops.services.hypridle.enable = lib.mkEnableOption "Enable hypridle";
  };

  config = lib.mkIf cfg.enable {
    desktops.programs.util.hyprlock.enable = true;
  
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
            timeout = 300;
            on-timeout = "brightnessctl -s set 10 && brightnessctl -sd asus:kbd_backlight set 0";
            on-resume = "brightnessctl -r && brightnessctl -rd asus:kbd_backlight";
          }
          {
            timeout = 900;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 1200;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 1800;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
}

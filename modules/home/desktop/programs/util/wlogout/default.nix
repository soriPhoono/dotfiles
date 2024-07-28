{ lib, pkgs, config, ... }:
let cfg = config.desktop.programs.util.wlogout;
in {
  options = {
    desktop.programs.util.wlogout = {
      enable = lib.mkEnableOption "Enable wlogout screen";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.wlogout = {
      enable = true;

      layout = [
        {
          label = "lock";
          circular = true;
          action = "hyprlock";
          text = "Lock";
          keybind = "l";
        }
        {
          label = "logout";
          circular = true;
          action = "loginctl terminate-user $USER";
          text = "Logout";
          keybind = "e";
        }
        {
          label = "reboot";
          circular = true;
          action = "systemctl reboot";
          text = "Reboot";
          keybind = "r";
        }
        {
          label = "power off";
          circular = true;
          action = "systemctl poweroff";
          text = "Shutdown";
          keybind = "s";
        }
      ];

      style =
        # css
        ''
        '';
    };
  };
}

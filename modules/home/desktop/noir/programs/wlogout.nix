{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  config = lib.mkIf cfg.enable {
    programs.wlogout = {
      enable = true;

      layout = [
        {
          label = "lock";
          action = "hyprlock";
          keybind = "l";
        }
        {
          label = "logout";
          action = "hyprctl dispatch exit";
          keybind = "q";
        }
        {
          label = "suspend";
          action = "systemctl suspend";
          keybind = "s";
        }
        {
          label = "hibernate";
          action = "systemctl hibernate";
          keybind = "h";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          keybind = "r";
        }
        {
          label = "shutdown";
          action = "systemctl poweroff";
          keybind = "s";
        }
      ];

      style = ''
        window {
          background-image: url("/tmp/shot-blur.png");
        }

        button {
          background-color: rgb(110, 115, 141);
          border-radius: 600px;
        }

        button:focus, button:active, button:hover {
        	background-color: rgb(145, 215, 227);
          outline-color: transparent;
        }

        #lock {
          background-image: image(url("${../../../../../assets/icons/system-lock-screen.svg}"));
        }

        #logout {
          background-image: image(url("${../../../../../assets/icons/system-log-out.svg}"));
        }

        #suspend {
          background-image: image(url("${../../../../../assets/icons/system-suspend.svg}"));
        }

        #hibernate {
          background-image: image(url("${../../../../../assets/icons/system-suspend-hibernate.svg}"));
        }

        #reboot {
          background-image: image(url("${../../../../../assets/icons/system-reboot.svg}"));
        }

        #shutdown {
          background-image: image(url("${../../../../../assets/icons/system-shutdown.svg}"));
        }
      '';
    };

    desktop.noir.extraBinds = let
      wlogout-script = pkgs.writeShellApplication {
        name = "wlogout-blur.sh";

        runtimeInputs = with pkgs; [
          grim
          imagemagick
          wlogout
        ];

        text = ''
          grim /tmp/shot.png
          magick /tmp/shot.png -blur 0x8 /tmp/shot-blur.png
          wlogout -p layer-shell
        '';
      };
    in [
      "$mod, L, exec, ${wlogout-script}/bin/wlogout-blur.sh"
    ];
  };
}

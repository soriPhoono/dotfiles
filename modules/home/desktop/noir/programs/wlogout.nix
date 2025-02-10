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

      layout = let
        shutdownScript = pkgs.writeShellApplication {
          name = "shutdown.sh";

          runtimeInputs = with pkgs; [
            swww

            waybar

            hyprland
          ];

          text = ''
            if pgrep swww-daemon; then swww kill; fi

            if pgrep waybar; then pkill waybar; fi

            hyprctl dispatch exit
          '';
        };
      in [
        {
          label = "lock";
          action = "hyprlock";
          keybind = "l";
        }
        {
          label = "hibernate";
          action = "systemctl hibernate";
          keybind = "h";
        }
        {
          label = "logout";
          action = "${shutdownScript}/bin/shutdown.sh";
          keybind = "q";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          keybind = "r";
        }
        {
          label = "suspend";
          action = "systemctl suspend";
          keybind = "s";
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
          background-repeat: no-repeat;
          background-position: center;
          background-size: 35%;
          border-radius: 30px;
        }

        button:focus, button:active, button:hover {
        	background-color: rgb(145, 215, 227);
          outline-color: transparent;
        }

        #lock {
          background-image: image(url("${../../../../../assets/icons/lock-screen.png}"));
        }

        #logout {
          background-image: image(url("${../../../../../assets/icons/log-out.png}"));
        }

        #suspend {
          background-image: image(url("${../../../../../assets/icons/suspend.png}"));
        }

        #hibernate {
          background-image: image(url("${../../../../../assets/icons/suspend-hibernate.png}"));
        }

        #reboot {
          background-image: image(url("${../../../../../assets/icons/reboot.png}"));
        }

        #shutdown {
          background-image: image(url("${../../../../../assets/icons/shutdown.png}"));
        }
      '';
    };

    wayland.windowManager.hyprland.settings.bind = let
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

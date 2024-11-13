{ inputs, lib, pkgs, config, nixosConfig, ... }:
let cfg = config.desktop.kde;
in {
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];

  options = {
    desktop.kde.enable = lib.mkOption {
      description = "Enable user customizations for plasma6";
      default = nixosConfig.services.desktopManager.plasma6.enable;
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      konsole = {
        enable = true;

        customColorSchemes = {
          catppuccin-mocha = pkgs.fetchFromGitHub
            {
              owner = "catppuccin";
              repo = "konsole";
              rev = "3b64040";
              sha256 = "d5+ygDrNl2qBxZ5Cn4U7d836+ZHz77m6/yxTIANd9BU=";
            } + "/themes/catppuccin-mocha.colorscheme";
        };

        defaultProfile = "catppuccin";

        profiles = {
          catppuccin = {
            colorScheme = "catppuccin-mocha";
          };
        };
      };

      plasma = {
        enable = true;
        immutableByDefault = true;

        input.keyboard = {
          repeatDelay = 300;
          repeatRate = 20;
        };

        desktop.icons = {
          folderPreviewPopups = true;
          sorting = {
            foldersFirst = true;
            mode = "type";
          };
        };

        panels = [
          # Windows-like panel at the bottom
          {
            location = "bottom";
            screen = "all";
            alignment = "center";
            hiding = "autohide";
            floating = true;
            lengthMode = "fit";
            widgets = [
              {
                kickoff = {
                  sortAlphabetically = true;
                  icon = "nix-snowflake-white";
                };
              }
              {
                iconTasks = {
                  launchers = [
                    "applications:org.kde.dolphin.desktop"
                    "applications:org.kde.konsole.desktop"
                  ];
                };
              }
              "org.kde.plasma.showdesktop"
            ];
          }
          {
            location = "top";
            screen = "all";
            height = 26;
            widgets = [
              "org.kde.plasma.systemmonitor.cpu"
              "org.kde.plasma.systemmonitor.memory"
              "org.kde.plasma.systemmonitor.diskusage"
              "org.kde.plasma.systemmonitor.net"
              "org.kde.plasma.panelspacer"
              {
                systemTray.items = {
                  shown = [
                  ];
                  hidden = [
                    "org.kde.plasma.battery"
                    "org.kde.plasma.bluetooth"
                    "org.kde.plasma.volume"
                    "org.kde.plasma.networkmanagement"
                    "org.kde.plasma.brightness"
                    "org.kde.plasma.clipboard"
                  ];
                };
              }
              "org.kde.plasma.networkmanagement"
              "org.kde.plasma.bluetooth"
              "org.kde.plasma.volume"
              "org.kde.plasma.battery"
              "org.kde.plasma.brightness"
              {
                digitalClock = {
                  date.enable = false;
                  time.format = "12h";
                };
              }
            ];
          }
        ];

        kwin.effects = {
          blur.enable = true;

          wobblyWindows.enable = true;
        };
      };
    };
  };
}

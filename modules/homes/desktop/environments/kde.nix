{ inputs, lib, config, nixosConfig, ... }:
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
    programs.plasma = {
      enable = true;

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
            # If no configuration is needed, specifying only the name of the
            # widget will add them with the default configuration.
            # "org.kde.plasma.marginsseparator"
            # If you need configuration for your widget, instead of specifying the
            # the keys and values directly using the config attribute as shown
            # above, plasma-manager also provides some higher-level interfaces for
            # configuring the widgets. See modules/widgets for supported widgets
            # and options for these widgets. The widgets below shows two examples
            # of usage, one where we add a digital clock, setting 12h time and
            # first day of the week to Sunday and another adding a systray with
            # some modifications in which entries to show.
            # {
            #   digitalClock = {
            #     calendar.firstDayOfWeek = "sunday";
            #     time.format = "12h";
            #   };
            # }
            # {
            #   systemTray.items = {
            #     # We explicitly show bluetooth and battery
            #     shown = [
            #       "org.kde.plasma.battery"
            #       "org.kde.plasma.bluetooth"
            #     ];
            #     # And explicitly hide networkmanagement and volume
            #     hidden = [
            #       "org.kde.plasma.networkmanagement"
            #       "org.kde.plasma.volume"
            #     ];
            #   };
            # }
          ];
        }
        # Application name, Global menu and Song information and playback controls at the top
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
                # We explicitly show bluetooth and battery and volume
                shown = [
                ];
                # And explicitly hide networkmanagement and volume
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
    };
  };
}

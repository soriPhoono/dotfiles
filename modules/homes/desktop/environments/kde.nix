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
          widgets = [
            # Or you can configure the widgets by adding the widget-specific options for it.
            # See modules/widgets for supported widgets and options for these widgets.
            # For example:
            {
              kickoff = {
                sortAlphabetically = true;
                icon = "nix-snowflake-white";
              };
            }
            # Adding configuration to the widgets can also for example be used to
            # pin apps to the task-manager, which this example illustrates by
            # pinning dolphin and konsole to the task-manager by default with widget-specific options.
            {
              iconTasks = {
                launchers = [
                  "applications:org.kde.dolphin.desktop"
                  "applications:org.kde.konsole.desktop"
                ];
              };
            }
            # If no configuration is needed, specifying only the name of the
            # widget will add them with the default configuration.
            "org.kde.plasma.marginsseparator"
            # If you need configuration for your widget, instead of specifying the
            # the keys and values directly using the config attribute as shown
            # above, plasma-manager also provides some higher-level interfaces for
            # configuring the widgets. See modules/widgets for supported widgets
            # and options for these widgets. The widgets below shows two examples
            # of usage, one where we add a digital clock, setting 12h time and
            # first day of the week to Sunday and another adding a systray with
            # some modifications in which entries to show.
            {
              digitalClock = {
                calendar.firstDayOfWeek = "sunday";
                time.format = "12h";
              };
            }
            {
              systemTray.items = {
                # We explicitly show bluetooth and battery
                shown = [
                  "org.kde.plasma.battery"
                  "org.kde.plasma.bluetooth"
                ];
                # And explicitly hide networkmanagement and volume
                hidden = [
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.volume"
                ];
              };
            }
          ];
          hiding = "autohide";
        }
        # Application name, Global menu and Song information and playback controls at the top
        {
          location = "top";
          height = 26;
          widgets = [
            {
              applicationTitleBar = {
                behavior = {
                  activeTaskSource = "activeTask";
                };
                layout = {
                  elements = [ "windowTitle" ];
                  horizontalAlignment = "left";
                  showDisabledElements = "deactivated";
                  verticalAlignment = "center";
                };
                overrideForMaximized.enable = false;
                titleReplacements = [
                  {
                    type = "regexp";
                    originalTitle = ''\\bDolphin\\b'';
                    newTitle = "File manager";
                  }
                ];
                windowTitle = {
                  font = {
                    bold = false;
                    fit = "fixedSize";
                    size = 12;
                  };
                  hideEmptyTitle = true;
                  margins = {
                    bottom = 0;
                    left = 10;
                    right = 5;
                    top = 0;
                  };
                  source = "appName";
                };
              };
            }
            "org.kde.plasma.appmenu"
            "org.kde.plasma.panelspacer"
            {
              plasmusicToolbar = {
                panelIcon = {
                  albumCover = {
                    useAsIcon = false;
                    radius = 8;
                  };
                  icon = "view-media-track";
                };
                playbackSource = "auto";
                musicControls.showPlaybackControls = true;
                songText = {
                  displayInSeparateLines = true;
                  maximumWidth = 640;
                  scrolling = {
                    behavior = "alwaysScroll";
                    speed = 3;
                  };
                };
              };
            }
          ];
        }
      ];
    };
  };
}

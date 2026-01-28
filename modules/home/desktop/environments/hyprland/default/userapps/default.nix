{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.environments.hyprland.default;
in
  with lib; {
    config = mkIf cfg.enable {
      userapps = {
        development.terminal.kitty.enable = true;
      };

      wayland.windowManager.hyprland.settings.bind = let
        defaultWebBrowser = let
          # Get the list of desktop files for text/html
          htmlDefaults = config.xdg.mimeApps.defaultApplications."text/html" or [];
          # Use the first one if available, otherwise throw an error
          desktopFile =
            if htmlDefaults != []
            then lib.head htmlDefaults
            else throw "No default browser found in xdg.mimeApps.defaultApplications.\"text/html\". This should be impossible as Chrome is the dynamic fallback.";
        in
          lib.removeSuffix ".desktop" desktopFile;
      in [
        "$mod, Return, exec, ${pkgs.uwsm}/bin/uwsm app ${config.programs.kitty.package}/bin/kitty"
        "$mod, B, exec, ${pkgs.uwsm}/bin/uwsm app ${defaultWebBrowser}"

        "$mod, Escape, exec, ${pkgs.uwsm}/bin/uwsm stop"
      ];
    };
  }

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
      desktop.environments.hyprland.binds = let
        # Helper to get default app from mimeApps
        getDefaultApp = mimeType: fallback: let
          defaults = config.xdg.mimeApps.defaultApplications.${mimeType} or [];
          desktopFile =
            if defaults != []
            then lib.head defaults
            else fallback;
        in
          lib.removeSuffix ".desktop" desktopFile;

        defaultTerminal = getDefaultApp "x-scheme-handler/terminal" (throw "No default terminal found");
        defaultWebBrowser = getDefaultApp "x-scheme-handler/http" (throw "No default browser found");
      in [
        {
          key = "Return";
          dispatcher = "exec";
          params = "${pkgs.uwsm}/bin/uwsm app -- ${defaultTerminal}";
        }
        {
          key = "B";
          dispatcher = "exec";
          params = "${pkgs.uwsm}/bin/uwsm app -- ${defaultWebBrowser}";
        }
        {
          key = "Escape";
          dispatcher = "exec";
          params = "${pkgs.uwsm}/bin/uwsm stop";
        }
      ];
    };
  }

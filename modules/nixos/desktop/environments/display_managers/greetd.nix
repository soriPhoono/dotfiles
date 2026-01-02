{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.environments.display_managers.greetd;
in
  with lib; {
    options.desktop.environments.display_managers.greetd = {
      enable = mkEnableOption "Enable greetd display manager.";

      defaultConfiguration = mkEnableOption "Use the default configuration for greetd suitable for a functioning system.";
    };

    config = mkIf cfg.enable {
      services = {
        greetd = {
          enable = true;

          useTextGreeter = cfg.defaultConfiguration;

          settings = mkIf (cfg.defaultConfiguration) {
            terminal.vt = 1;

            default_session = {
              command = "${pkgs.tuigreet}/bin/tuigreet --time --greeting 'Welcome to Project Chimera'";
              user = "greeter";
            };
          };
        };
      };
    };
  }

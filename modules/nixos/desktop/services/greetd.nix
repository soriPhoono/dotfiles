{ lib, config, ... }:
let cfg = config.desktop.services.greetd;
in {
  options = {
    desktop.services.greetd = {
      enable = lib.mkEnableOption "Enable greetd login manager";

      launch_command = lib.mkOption {
        type = lib.types.str;

        description = "The command greetd executes on launch";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;

      settings = {
        default_session = {
          command = cfg.launch_command;
        };
      };
    };
  };
}

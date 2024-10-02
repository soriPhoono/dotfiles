{ lib, config, ... }:
let cfg = config.core.shells.starship;
in {
  options = {
    config.core.shells.starship.enable =
      lib.mkEnableOption "Enable starship prompt";
  };

  config = lib.mkIf cfg.enable {
    starship = {
      enable = true;
      enableFishIntegration = cfg.fish.enable;
      enableTransience = cfg.fish.enable;

      settings = {
        add_newline = true;

        format = "$character";
        right_format = "$all";

        character = {
          success_symbol = "[➜](bold green) ";
          error_symbol = "[➜](bold red) ";
        };
      };
    };
  };
}

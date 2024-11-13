{ lib, config, ... }:
let cfg = config.core.programs.starship;
in {
  options = {
    core.programs.starship = {
      enable = lib.mkEnableOption "Enable starship prompt";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = config.core.shells.fish.enable;
      enableTransience = config.core.shells.fish.enable;

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

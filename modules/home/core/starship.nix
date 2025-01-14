{ lib, config, ... }:
let
  cfg = config.core.starship;
in
{
  options.core.starship = {
    enable = lib.mkEnableOption "Enable starship prompt";
  };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;

      enableFishIntegration = config.core.fish.enable;
      enableTransience = config.core.fish.enable;

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

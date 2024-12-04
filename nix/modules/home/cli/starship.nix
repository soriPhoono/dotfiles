{ config, ... }: {
  programs.starship = {
      enable = true;
      enableFishIntegration = config.cli.fish.enable;
      enableTransience = config.cli.fish.enable;

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
}

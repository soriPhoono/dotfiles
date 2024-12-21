{ config, ... }: {
  programs.starship = {
    enable = true;
    enableFishIntegration = config.global.fish.enable;
    enableTransience = config.global.fish.enable;

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

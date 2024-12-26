{ config, ... }: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableTransience = true;

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

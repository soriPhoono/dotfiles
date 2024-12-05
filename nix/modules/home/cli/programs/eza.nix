{ config, ... }: {
  programs.eza = {
    enable = true;
    enableFishIntegration = config.cli.fish.enable;

    extraOptions = [ "--group-directories-first" ];

    git = true;
    icons = "auto";
  };
}

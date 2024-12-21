{ config, ... }: {
  programs.eza = {
    enable = true;
    enableFishIntegration = config.global.fish.enable;

    extraOptions = [ "--group-directories-first" ];

    git = true;
    icons = "auto";
  };
}

{ config, ... }: {
  programs.eza = {
    enable = true;
    enableFishIntegration = true;

    extraOptions = [ "--group-directories-first" ];

    git = true;
    icons = "auto";
  };
}

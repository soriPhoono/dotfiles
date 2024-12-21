{ config, ... }: {
  programs.nix-index = {
    enable = true;

    enableBashIntegration = true;
    enableFishIntegration = config.global.fish.enable;
  };
}

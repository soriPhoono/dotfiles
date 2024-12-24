{ config, ... }: {
  programs.nix-index = {
    enable = true;

    enableBashIntegration = true;
    enableFishIntegration = config.cli.fish.enable;
  };
}

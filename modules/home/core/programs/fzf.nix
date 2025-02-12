{config, ...}: {
  programs.fzf = {
    enable = true;
    enableFishIntegration = config.programs.fish.enable;

    defaultCommand = "fd --type file";
    defaultOptions = [
      "--ansi"
    ];
  };
}

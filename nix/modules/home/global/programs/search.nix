{ config, ... }: {
  programs = {
    fd = {
      enable = true;
      hidden = true;

      extraOptions = [
        "--follow"
        "--color=always"
      ];

      ignores = [
        ".git"
        "*.bak"
      ];
    };

    fzf = {
      enable = true;
      enableFishIntegration = config.global.fish.enable;

      defaultCommand = "fd --type file";
      defaultOptions = [
        "--ansi"
      ];
    };
  };
}

{ config, pkgs, ... }: {
  programs.git = {
    enable = true; # Enable git

    config = {
      init = {
        defaultBranch = "main"; # Use ‘main’ as the default branch
      };
      url = {
        "https://github.com/" = {
          insteadOf = [
            "gh:" # Use ‘gh:’ as a prefix for GitHub URLs
            "github:" # Use ‘github:’ as a prefix for GitHub URLs
          ];
        };
      };
    };
  };
}

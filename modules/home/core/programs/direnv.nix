{
  programs.direnv = {
    enable = true;

    nix-direnv.enable = true;
  };

  core.impermanence.directories = [
    ".local/share/direnv"
  ];
}

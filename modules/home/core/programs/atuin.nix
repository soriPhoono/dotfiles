{
  programs.atuin = {
    enable = true;
    daemon.enable = true;

    # TODO: setup sync server
  };

  core.impermanence.directories = [
    ".local/share/atuin"
  ];
}

{ ... }: {
  programs = {
    fastfetch.enable = true;

    fish.interactiveShellInit = ''
      fastfetch
    '';
  };
}

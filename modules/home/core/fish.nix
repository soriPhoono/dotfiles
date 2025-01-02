{
  programs.fish = {
    enable = true;

    shellInitLast = ''
      set fish_greeting

      fastfetch

      nix-index
    '';
  };
}

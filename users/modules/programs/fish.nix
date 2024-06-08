{ ... }: {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
      
      fastfetch
    '';

    shellAliases = {
      ls = "eza";
      ll = "eza -l";
      lt = "eza -T";

      du = "dua i";
      df = "duf";

      clock = "scc";
      cat = "bat";
    };
  };
}

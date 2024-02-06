{ pkgs, ... }: {
  programs = {
    zsh = {
      enable = true; # Enable zsh

      autosuggestions = {
        enable = true; # Enable zsh-autosuggestions
        strategy = [
          "history" # Use history to determine suggestions
          "completion" # Use completion to determine suggestions
          "match_prev_cmd" # Use previous command to determine suggestions
        ];
      };

      syntaxHighlighting = {
        enable = true; # Enable zsh-syntax-highlighting
        highlighters = [
          "main" # Enable main highlighter
          "brackets" # Enable bracket highlighter
          "pattern" # Enable pattern highlighter
          "cursor" # Enable cursor highlighter
          "regexp" # Enable regexp highlighter
          "root" # Enable root highlighter
          "line" # Enable line highlighter
        ];
      };

      shellAliases = {
        ls = "eza"; # Use eza as the replacement for ls
        cat = "bat"; # Use bat as the replacement for cat
        du = "dua"; # Use dua as the replacement for du
        df = "duf"; # Use duf as the replacement for df
        tree = "tre"; # Use tre as the replacement for tree
        clock = "scc"; # Use scc as the replacement for clock
      };
    };
  };
}

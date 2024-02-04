{ pkgs, ... }: {
  networking = {
    networkmanager.enable = true;
  };

  programs = {
    zsh = {
      enable = true;

      autosuggestions = {
        enable = true;
        strategy = [
          "history"
          "completion"
          "match_prev_cmd"
        ];
      };

      syntaxHighlighting = {
        enable = true;
        highlighters = [
          "main"
          "brackets"
          "pattern"
          "cursor"
          "regexp"
          "root"
          "line"
        ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    pkgs.man
    pkgs.man-pages
    pkgs.texinfo
    
    pkgs.ntfs3g
  ];

  users = {
    defaultUserShell = pkgs.zsh;
  };
}

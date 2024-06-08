{ ... }: {
  programs = {
    fish.shellAliases = {
      ls = "eza";
      ll = "eza -l";
      lt = "eza -T";
    };

    eza = {
      enable = true;

      extraOptions = [
        "--group-directories-first"
        "--hyperlink"
      ];

      git = true;
      icons = true;
    };
  };
}

{ ... }: {
  programs.eza = {
    enable = true;

    extraOptions = [
      "--group-directories-first"
      "--hyperlink"
    ];

    git = true;
    icons = true;
  };
}

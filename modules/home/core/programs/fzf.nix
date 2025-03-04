{
  programs.fzf = {
    enable = true;

    defaultCommand = "fd --type file";
    defaultOptions = [
      "--ansi"
    ];
  };
}

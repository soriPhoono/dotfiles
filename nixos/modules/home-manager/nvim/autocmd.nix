{
  programs.nixvim.autoCmd = [
    {
      event = "FileType";
      pattern = "help";
      command = "wincmd L";
    }
    {
      event = "FileType";
      pattern = [ "tex" "latex" "markdown" ];
      command = "setlocal spell spelllang=en";
    }
  ];
}

{
  programs.nixvim.autoCmd = [
    {
      event = "InsertEnter";
      command = "norm zz";
    }
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

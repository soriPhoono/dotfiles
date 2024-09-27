{
  programs.nixvim = {
    opts = {
      encoding = "utf-8";
      fileencoding = "utf-8";

      number = true;

      title = true;
      autoindent = true;
      smartindent = true;
      hlsearch = true;
      backup = false;
      showcmd = true;
      cmdheight = 0;
      laststatus = 0;
      expandtab = true;
      scrolloff = 10;
      inccommand = "split";
      ignorecase = true;
      smarttab = true;
      breakindent = true;
      shiftwidth = 2;
      tabstop = 2;
      wrap = false;
      backspace = [ "start" "eol" "indent" ];
      wildignore = [ "*/node_modules/*" ];
      path = [ "**" ];
      splitbelow = true;
      splitright = true;
      splitkeep = true;
      mouse = "";

      formatoptions = [ "r" ];
    };
  };
}

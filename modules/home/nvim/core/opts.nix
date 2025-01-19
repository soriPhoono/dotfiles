{
  programs.nixvim = {
    clipboard.providers.wl-copy.enable = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    opts = {
      termguicolors = true;
      updatetime = 500;

      number = true;
      cursorline = true;
      incsearch = true;
      hlsearch = true;

      spell = true;
      spelllang = "en";

      expandtab = true;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;

      foldenable = false;
      foldmethod = "expr";
      foldexpr = "v:lua.vim.treesitter.foldexpr()";

      history = 2000;
      undofile = true;

      splitright = true;
      splitbelow = true;

      cmdheight = 0;
      laststatus = 3;
    };

    colorschemes.catppuccin = {
      enable = true;
      settings.transparent_background = true;
    };
  };
}

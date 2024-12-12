{ ... }: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes.catppuccin = {
      enable = true;
      settings.transparent_background = true;
    };

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

    keymaps = [
      {
        action = "<cmd>w<CR>";
        key = "<C-s>";
        options = {
          silent = true;
          desc = "Close current file or editor";
        };
      }
      {
        action = "<cmd>qall<CR>";
        key = "<C-q>";
        options = {
          silent = true;
          desc = "Close the editor";
        };
      }
    ];
  };
}

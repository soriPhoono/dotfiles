{ ... }: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    clipboard.providers.wl-copy.enable = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    opts = {
      termguicolors = true;
      colorcolumn = "80";
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
        key = "<leader>w";
        options = {
          silent = true;
          desc = "Save current file";
        };
      }
      {
        action = "<cmd>q<CR>";
        key = "<leader>q";
        options = {
          silent = true;
          desc = "Close current file or editor";
        };
      }
      {
        action = "<cmd>Q<CR>";
        key = "<leader>qa";
        options = {
          silent = true;
          desc = "Close current editor";
        };
      }
    ];
  };
}

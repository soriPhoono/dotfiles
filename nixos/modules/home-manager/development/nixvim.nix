{ inputs, lib, config, ... }: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  home.shellAliases.v = "nvim";

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;

    globals = {
      loaded_ruby_provider = 0;
      loaded_perl_provider = 0;
      loaded_python_provider = 0;

      mapleader = " ";
      maplocalleader = " ";
    };

    opts = {
      updatetime = 100;

      relativenumber = false;
      number = true;
      hidden = true;

      mouse = "a";
      mousemodel = "extend";

      splitbelow = true;
      splitright = true;

      swapfile = false;
      modeline = true;
      modelines = 100;

      undofile = true;

      incsearch = true;
      inccommand = "split";

      ignorecase = true;
      smartcase = true;

      scrolloff = 8;

      cursorline = false;
      cursorcolumn = false;
      signcolumn = "yes";
      colorcolumn = "100";

      laststatus = 3;
      fileencoding = "utf-8";
      termguicolors = true;
      spell = false;

      wrap = false;

      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      autoindent = true;

      textwidth = 0;

      foldlevel = 99;

      completeopt = [ "menu" "menuone" "noselect" ];
    };

    autoCmd = [
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
        pattern = [
          "tex"
          "latex"
          "markdown"
        ];
        command = "setlocal spell spelllang=en";
      }
    ];

    keymaps = let
      normal =
        lib.mapAttrsToList
        (key: action: {
          mode = "n";
          inherit action key;
        })
        {
          # clear search history via esc
          "<esc>" = ":noh<CR>";

          # close via ctrl-q, save via ctrl-s
          "<C-q>" = ":close<CR>";
          "<C-s>" = ":w<CR>";

          # navigate to left/right window
          "<leader>h" = "<C-w>h";
          "<leader>l" = "<C-w>l";

          # resize with arrows
          "<C-Up>" = ":resize -2<CR>";
          "<C-Down>" = ":resize +2<CR>";
          "<C-Left>" = ":vertical resize +2<CR>";
          "<C-Right>" = ":vertical resize -2<CR>";

          # move current line up/down
          # M = Alt key
          "<M-k>" = ":move-2<CR>";
          "<M-j>" = ":move+<CR>";
        };
      in
        config.nixvim.helpers.keymaps.mkKeymaps
        {options.silent = true;}
        (normal);

    colorschemes.catppuccin = {
      enable = true;

      settings.transparent_background = true;
    };

    highlight = {
      Todo = {
        fg = "Yellow";
        bg = "White";
      };
    };

    match = {
      TODO = "TODO";
    };

    editorconfig.enable = true;

    plugins = {
      neo-tree = {
        enable = true;

        popupBorderStyle = "rounded";
      };

      telescope.enable = true;

      treesitter.enable = true;
      luasnip.enable = true;

      lspkind = {
        enable = true;

        cmp = {
          enable = true;

          menu = {
            nvim_lsp = "[LSP]";
            nvim_lua = "[api]";
            path = "[path]";
            luasnip = "[snip]";
            buffer = "[buffer]";
            neorg = "[neorg]";
            cmp_tabby = "[Tabby]";
          };
        };
      };

      cmp = {
        enable = true;

        settings = {
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";

          mapping = {
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };

          sources = [
            {name = "path";}
            {name = "nvim_lsp";}
            {name = "cmp_tabby";}
            {name = "luasnip";}
            {
              name = "buffer";
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            }
            {name = "neorg";}
          ];
        };
      };

      comment = {
        enable = true;

        settings = {
          opleader.line = "<C-b>";
          toggler.line = "<C-b>";
        };
      };

      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
        };
      };

      nvim-autopairs.enable = true;

      nvim-colorizer = {
        enable = true;
        userDefaultOptions.names = false;
      };

      oil.enable = true;

      trim = {
        enable = true;
        settings = {
          highlight = true;
          ft_blocklist = [
            "checkhealth"
            "floaterm"
            "lspinfo"
            "neo-tree"
            "TelescopePrompt"
          ];
        };
      };
    };
  };
}

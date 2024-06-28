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
      normal_keymap =
        lib.mapAttrsToList
        (key: action: {
          mode = "n";
          inherit action key;
        })
        {
          # clear search history via esc
          "<esc>" = ":noh<CR>";

          # close via ctrl-q, save via ctrl-s
          "<C-q>" = ":qa<CR>";
          "<leader>q" = ":close<CR>";
          "<leader>w" = ":w<CR>";

          # navigate to left/right window
          "<leader>Left" = "<C-w>h";
          "<leader>Right" = "<C-w>l";

          # resize with arrows
          "<C-Up>" = ":resize -2<CR>";
          "<C-Down>" = ":resize +2<CR>";
          "<C-Left>" = ":vertical resize +2<CR>";
          "<C-Right>" = ":vertical resize -2<CR>";

          # move current line up/down
          # M = Alt key
          "<M-Up>" = ":move-2<CR>";
          "<M-Down>" = ":move+<CR>";

          # plugins
          "<leader>e" = ":Neotree reveal toggle<CR>";
          "<leader>g" = ":TagbarToggle<CR>";
        };
      in
        config.nixvim.helpers.keymaps.mkKeymaps
        {
          options.silent = true;
        }
        (normal_keymap);

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
        closeIfLastWindow = true;

        window = {
          width = 30;
          autoExpandWidth = true;

          position = "float";
        };
      };

      tagbar = {
        enable = true;
        settings.width = 50;
      };

      markdown-preview = {
        enable = true;

        settings = {
          auto_close = false;
          theme = "dark";
        };
      };

      neorg = {
        enable = false; # TODO re-enable when neorg is fixed

        modules = {
          "core.defaults".__empty = null;

          "core.keybinds".config.hook.__raw = ''
            function(keybinds)
              keybinds.unmap('norg', 'n', '<C-s>')

              keybinds.map(
                'norg',
                'n',
                '<leader>c',
                ':Neorg toggle-concealer<CR>',
                {silent=true}
              )
            end
          '';

          "core.dirman".config.workspaces = {
            notes = "~/notes";
            nix = "~/perso/nix/notes";
          };

          "core.concealer".__empty = null;
          "core.completion".config.engine = "nvim-cmp";
          "core.qol.toc".config.close_after_use = true;
        };
      };

      telescope = {
        enable = true;

        keymaps = {
          # Find files using Telescope command-line sugar.
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>b" = "buffers";
          "<leader>fh" = "help_tags";
          "<leader>fd" = "diagnostics";

          # FZF like bindings
          "<C-p>" = "git_files";
          "<leader>p" = "oldfiles";
          "<C-f>" = "live_grep";
        };

        settings.defaults = {
          file_ignore_patterns = [
            "^.git/"
            "^.mypy_cache/"
            "^__pycache__/"
            "^output/"
            "^data/"
            "%.ipynb"
          ];
          set_env.COLORTERM = "truecolor";
        };
      };

      treesitter = {
        enable = true;

        nixvimInjections = true;

        folding = true;
        indent = true;
      };

      treesitter-refactor = {
        enable = true;
        highlightDefinitions = {
          enable = true;
          # Set to false if you have an `updatetime` of ~100.
          clearOnCursorMove = false;
        };
      };

      hmts.enable = true;

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

      barbar = {
        enable = true;
        keymaps = {
          next.key = "<TAB>";
          previous.key = "<S-TAB>";
          close.key = "<C-w>";
        };
      };

      lualine = {
        enable = true;

        globalstatus = true;

        # +-------------------------------------------------+
        # | A | B | C                             X | Y | Z |
        # +-------------------------------------------------+
        sections = {
          lualine_a = ["mode"];
          lualine_b = ["branch"];
          lualine_c = ["filename" "diff"];

          lualine_x = [
            "diagnostics"

            # Show active language server
            {
              name.__raw = ''
                function()
                    local msg = ""
                    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                    local clients = vim.lsp.get_active_clients()
                    if next(clients) == nil then
                        return msg
                    end
                    for _, client in ipairs(clients) do
                        local filetypes = client.config.filetypes
                        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                            return client.name
                        end
                    end
                    return msg
                end
              '';
              icon = "";
              color.fg = "#ffffff";
            }
            "encoding"
            "fileformat"
            "filetype"
          ];
        };
      };

      floaterm = {
        enable = true;

        width = 0.8;
        height = 0.8;

        title = "";

        keymaps.toggle = "<leader>,";
      };

      lsp = {
        enable = true;

        keymaps = {
          silent = true;

          diagnostic = {
            "<C-Left>" = "goto_prev";
            "<C-Right>" = "goto_next";
          };

          lspBuf = {
            gd = "definition";
            gD = "references";
            gt = "type_definition";
            gi = "implementation";
            K = "hover";
            "<F2>" = "rename";
          };
        };

        servers = {
          nil-ls.enable = true;
          bashls.enable = true;

          clangd.enable = true;
          cmake.enable = true;

          dartls.enable = true;

          cssls.enable = true;
          denols.enable = true;
        };
      };

      lsp-format = {
        enable = true;

        lspServersToEnable = [  ];
      };

      startify = {
        enable = true;

        settings = {
          custom_header = [
            ""
            "     ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
            "     ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
            "     ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
            "     ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
            "     ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
            "     ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
          ];

          # When opening a file or bookmark, change to its directory.
          change_to_dir = false;

          # By default, the fortune header uses ASCII characters, because they work for everyone.
          # If you set this option to 1 and your 'encoding' is "utf-8", Unicode box-drawing characters will
          # be used instead.
          use_unicode = true;

          lists = [{type = "dir";}];
          files_number = 30;

          skiplist = [
            "flake.lock"
          ];
        };
      };
    };

    files = {
      "after/ftplugin/markdown.lua".keymaps = [
        {
          mode = "n";
          key = "<leader>m";
          action = ":MarkdownPreview<cr>";
        }
      ];
      "after/ftplugin/norg.lua" = {
        localOpts.conceallevel = 1;

        keymaps = [
          {
            mode = "n";
            key = "<C-g>";
            action = ":Neorg toc<CR>";
            options.silent = true;
          }
        ];
      };
    };
  };
}

{ ... }: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes.catppuccin = {
      enable = true;

      settings.flavor = "mocha";
    };

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

      foldenable = true;

      history = 2000;
      undofile = true;

      splitright = true;
      splitbelow = true;

      cmdheight = 0;
      laststatus = 3;
    };

    keymaps = [
      {
        action = "<cmd>ToggleTerm<CR>";
        key = "<leader>t";
        options = {
          silent = true;
          desc = "Open Terminal";
        };
      }
      {
        action = "<cmd>LazyGit<CR>";
        key = "<leader>g";
        options = {
          silent = true;
          desc = "Open LazyGit";
        };
      }

      {
        action = "<cmd>wq<CR>";
        key = "<leader>w";
        options = {
          silent = true;
          desc = "Save and close current file or editor";
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

    plugins = {
      toggleterm.enable = true;

      lsp = {
        enable = true;

        servers.nixd = {
          enable = true;
          settings.formatting.command = [
            "nixpkgs-fmt"
          ];
        };
      };

      lspkind = {
        enable = true;
        mode = "symbol";
      };

      cmp = {
        enable = true;
        autoEnableSources = true;

        cmdline = {
          "/" = {
            mapping = {
              __raw = "cmp.mapping.preset.cmdline()";
            };
            sources = [
              {
                name = "buffer";
              }
            ];
          };
          ":" = {
            mapping = {
              __raw = "cmp.mapping.preset.cmdline()";
            };
            sources = [
              {
                name = "path";
              }
              {
                name = "cmdline";
                option = {
                  ignore_cmds = [
                    "Man"
                    "!"
                  ];
                };
              }
            ];
          };
        };

        filetype = {
          lua = {
            sources = [
              {
                name = "nvim_lua";
              }
              {
                name = "nvim_lsp";
                keyword_length = 3;
              }
              {
                name = "path";
              }
              {
                name = "buffer";
              }
            ];
          };
        };

        settings = {
          sources = [
            {
              name = "nvim_lsp";
              keyword_length = 3;
            }
            {
              name = "luasnip";
            }
            {
              name = "path";
            }
            {
              name = "buffer";
            }
          ];
        };
      };
    };
  };
}

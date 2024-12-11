{ ... }: {
  programs.nixvim = {
    keymaps = [
      {
        action = "<cmd>lua vim.lsp.buf.format()<CR>";
        key = "<leader>lf";
        options = {
          silent = true;
          desc = "Format the current buffer";
        };
      }
      {
        action = "<cmd>Lspsaga finder<CR>";
        key = "<leader>ls";
        options = {
          silent = true;
          desc = "Find all references";
        };
      }
      {
        action = "<cmd>Lspsaga outline<CR>";
        key = "<leader>lo";
        options = {
          silent = true;
          desc = "Show document outline";
        };
      }
      {
        action = "<cmd>Neotree toggle<CR>";
        key = "<leader>e";
        options = {
          silent = true;
          desc = "Open file explorer";
        };
      }
    ];

    plugins = {
      autoclose.enable = true;
      commentary.enable = true;
      gitsigns.enable = true;

      lspkind = {
        enable = true;
        mode = "symbol";
      };

      neo-tree = {
        enable = true;
        closeIfLastWindow = true;

        window.position = "float";
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
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
        };
      };

      telescope = {
        enable = true;

        keymaps = {
          "<leader>f" = "git_files";
          "<leader>g" = "live_grep";
        };

        settings = {
          defaults = {
            path_display = [
              "truncate"
            ];
            preview = {
              treesitter = true;
            };
            color_devicons = true;
            prompt_prefix = "";
            selection_caret = " ";
            entry_prefix = " ";
            initial_mode = "insert";
            vimgrep_arguments = [
              "rg"
              "-L"
              "--color=never"
              "--no-heading"
              "--with-filename"
              "--line-number"
              "--column"
              "--smart-case"
            ];
          };
        };
      };

      treesitter-context.enable = true;
      ts-context-commentstring.enable = true;

      treesitter = {
        enable = true;

        settings = {
          highlight = {
            enable = true;
            additional_vim_regex_highlighting = true;
          };
          indent.enable = true;
        };
      };
    };
  };
}

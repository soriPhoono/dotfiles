{ pkgs, ... }: {
  programs.nixvim = {
    keymaps = [
      {
        action = "<cmd>Commentary<CR>";
        key = "<leader>c";
        options = {
          silent = true;
          desc = "Comment current line";
        };
      }
    ];

    plugins = {
      autoclose.enable = true;
      commentary.enable = true;

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
            prompt_prefix = " ";
            selection_caret = " ";
            entry_prefix = " ";
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

        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          norg
        ];

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

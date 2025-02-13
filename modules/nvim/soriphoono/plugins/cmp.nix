{
  plugins = {
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
        neorg = {
          sources = [
            {
              name = "neorg";
            }
            {
              name = "path";
            }
            {
              name = "buffer";
            }
          ];
        };
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
        snippet = {
          expand =
            # lua
            ''
              function(args)
                require('luasnip').lsp_expand(args.body)
              end
            '';
        };

        completion = {
          completeopt = "menu,menuone,noinsert";
        };

        sources = [
          {
            name = "nvim_lsp";
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

        window = let
          border = [
            "╭"
            "─"
            "╮"
            "│"
            "╯"
            "─"
            "╰"
            "│"
          ];
        in {
          completion.border = border;
          documentation.border = border;
        };
      };
    };
  };
}

{ ... }: {
  programs.nixvim.plugins = {
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
  };
}

{
  programs.nixvim.plugins = {
    luasnip.enable = true;

    copilot-lua = {
      enable = true;

      suggestion.enabled = false;
      panel.enabled = false;

      filetypes = {
        yaml = false;
        markdown = false;
        gitcommit = false;
        gitrebase = false;
        cvs = false;
        help = false;
        "." = false;
      };
    };

    cmp = {
      enable = true;

      settings = {
        experimental.ghost_text = true;

        snippet.expand =
          # lua
          ''
            function(args)
                require('luasnip').lsp_expand(args.body)
            end
          '';

        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<ESC>" = "cmp.mapping.close()";
          "<Tab>" =
            # lua
            ''
              function(fallback)
                local line = vim.api.nvim_get_current_line()
                if line:match("^%s*$") then
                  fallback()
                elseif cmp.visible() then
                  cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
                else
                  fallback()
                end
              end
            '';
          "<Down>" =
            # lua
            ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif require("luasnip").expand_or_jumpable() then
                  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
                else
                  fallback()
                end
              end
            '';
          "<Up>" =
            # lua
            ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif require("luasnip").jumpable(-1) then
                  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
                else
                  fallback()
                end
              end
            '';
        };

        sources = [
          { name = "luasnip"; }
          { name = "path"; }
          {
            name = "buffer";
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
          }
          { name = "nvim_lsp"; }
          { name = "copilot"; }
        ];

        window = {
          completion = {
            winhighlight =
              "FloatBorder:CmpBorder,Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel";
            scrollbar = false;
            sidePadding = 0;
            border = [ "╭" "─" "╮" "│" "╯" "─" "╰" "│" ];
          };

          settings.documentation = {
            border = [ "╭" "─" "╮" "│" "╯" "─" "╰" "│" ];
            winhighlight =
              "FloatBorder:CmpBorder,Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel";
          };
        };
      };
    };

    cmp_luasnip.enable = true;
    cmp-path.enable = true;
    cmp-buffer.enable = true;
    cmp-nvim-lsp.enable = true;

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

        gopls.enable = true;

        kotlin-language-server.enable = true;
      };
    };

    lsp-format.enable = true;

    lsp-lines.enable = true;

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

    none-ls = {
      enable = true;
      sources = {
        diagnostics = {
          statix.enable = true;

          golangci_lint.enable = true;

          ktlint.enable = true;
        };
        formatting = {
          nixfmt.enable = true;

          shfmt.enable = true;
          shellharden.enable = true;

          goimports.enable = true;
          gofmt.enable = true;

          ktlint.enable = true;

          markdownlint.enable = true;
        };
      };
    };

    rust-tools.enable = true;
  };
}

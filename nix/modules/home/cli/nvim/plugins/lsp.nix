{ pkgs, ... }: {
  programs.nixvim = {
    keymaps = [
      {
        action = "<cmd>Lspsaga rename<CR>";
        key = "<leader>lr";
        options = {
          silent = true;
          desc = "Rename token";
        };
      }
      {
        action = "<cmd>lua vim.lsp.buf.format()<CR><cmd>%foldopen!<CR>";
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
        action = "<cmd>Lspsaga subtypes<CR>";
        key = "<leader>lt";
        options = {
          silent = true;
          desc = "Show variable subtypes";
        };
      }
      {
        action = "<cmd>Lspsaga supertypes<CR>";
        key = "<leader>lT";
        options = {
          silent = true;
          desc = "Show variable supertypes";
        };
      }
      {
        action = "<cmd>Lspsaga code_action<CR>";
        key = "<leader>la";
        options = {
          silent = true;
          desc = "Show code actions at cursor location";
        };
      }
      {
        action = "<cmd>Lspsaga peek_definition<CR>";
        key = "<leader>ld";
        options = {
          silent = true;
          desc = "Peek at definition under cursor";
        };
      }
      {
        action = "<cmd>Lspsaga goto_definition<CR>";
        key = "<leader>lD";
        options = {
          silent = true;
          desc = "Goto definition under cursor";
        };
      }
      {
        action = "<cmd>Lspsaga peek_type_definition<CR>";
        key = "<leader>ltd";
        options = {
          silent = true;
          desc = "Peek at type definition";
        };
      }
      {
        action = "<cmd>Lspsaga goto_type_definition<CR>";
        key = "<leader>ltD";
        options = {
          silent = true;
          desc = "Goto type definition";
        };
      }
      {
        action = "<cmd>Lspsaga show_workspace_diagnostics<CR>";
        key = "<leader>lw";
        options = {
          silent = true;
          desc = "Show workspace diagnostics";
        };
      }
    ];

    plugins = {
      lspsaga.enable = true;

      lsp = {
        enable = true;

        servers = {
          nixd = {
            enable = true;

            settings.formatting.command = [
              "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt"
            ];
          };

          bashls.enable = true;

          clangd.enable = true;

          zls.enable = true;
          rust_analyzer = {
            enable = true;

            installCargo = true;
            installRustc = true;
          };

          java_language_server.enable = true;

          pylsp.enable = true;

          lua_ls.enable = true;
        };
      };
    };
  };
}

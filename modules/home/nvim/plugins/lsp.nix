{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.nvim;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      keymaps = [
        {
          action = "<cmd>lua vim.diagnostic.setloclist()<cr>";
          key = "<leader>q";
          options.desc = "Open diagnostic Quickfix list";
        }
        {
          action = "<cmd>lua vim.lsp.buf.rename<cr>";
          key = "<leader>lr";
          options.desc = "Rename symbol under cursor";
        }
        {
          action = "<cmd>lua vim.lsp.buf.code_action<cr>";
          key = "<leader>lc";
          options.desc = "Trigger code action under cursor";
        }
        {
          action = "<cmd>lua vim.lsp.buf.declaration<cr>";
          key = "<leader>ld";
          options.desc = "Goto declaration";
        }
        {
          action = "<cmd>lua vim.lsp.buf.format()<CR>";
          key = "<leader>lf";
          options.desc = "Format the current buffer";
        }
      ];

      plugins.lsp = {
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

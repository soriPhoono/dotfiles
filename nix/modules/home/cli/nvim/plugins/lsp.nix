{ pkgs, ... }: {
  programs.nixvim = {
    keymaps = [
      {
        action = "<cmd>lua vim.lsp.buf.format()<CR><cmd>%foldopen!<CR>";
        key = "<leader>lf";
        options = {
          silent = true;
          desc = "Format the current buffer";
        };
      }
      {
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
        key = "<leader>lh";
        options = {
          silent = true;
          desc = "Hover on token";
        };
      }
    ];

    plugins = {
      lint.enable = true;

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

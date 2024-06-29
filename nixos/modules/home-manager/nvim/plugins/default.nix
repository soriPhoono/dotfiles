{ ... }: {
  imports = [
    ./ui.nix
    ./treesitter.nix
    ./lsp.nix
    ./dap.nix
  ];

  programs.nixvim = {
    plugins = {
      comment = {
        enable = true;

        settings = {
          opleader.line = "<leader>c";
          toggler.line = "<leader>c";
        };
      };

      nvim-autopairs.enable = true;

      nvim-colorizer = {
        enable = true;
        userDefaultOptions.names = false;
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
    };
  };
}

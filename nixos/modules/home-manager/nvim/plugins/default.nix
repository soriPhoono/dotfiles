{ ... }: {
  imports = [
    ./ui.nix
    ./treesitter.nix
    ./lsp.nix
  ];

  programs.nixvim = {
    plugins = {
      markdown-preview = {
        enable = true;

        settings = {
          auto_close = false;
          theme = "dark";
        };
      };

      comment = {
        enable = true;

        settings = {
          opleader.line = "<C-b>";
          toggler.line = "<C-b>";
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

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

      plugins.auto-save = {
        enable = true;
        settings.enabled = true;
      };

      nvim-colorizer = {
        enable = true;
        userDefaultOptions.names = false;
      };

      indent-blankline = {
        enable = true;
        settings = {
          indent = {
            smart_indent_cap = true;
            char = " ";
          };
          scope = {
            enabled = true;
            char = "│";
          };
        };
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

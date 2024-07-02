{
  imports = [ ./ui.nix ./treesitter.nix ./lsp.nix ];

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

      auto-save = {
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
  };
}

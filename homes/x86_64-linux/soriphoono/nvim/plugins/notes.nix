{
  programs.nvf.settings.vim.notes = {
    todo-comments.enable = true;

    neorg = {
      enable = true;

      treesitter.enable = true;

      setupOpts.load = {
        "core.defaults".enable = true;
        "core.completion" = {
          enable = true;
          config = {
            engine = "nvim-cmp";
          };
        };
        "core.concealer".enable = true;
        "core.dirman" = {
          enable = true;
          config = {
            workspaces.default = "~/Documents/Notes";
          };
        };
        "core.export.markdown" = {
          enable = true;
          config = {
            extensions = "all";
          };
        };
        "core.summary".enable = true;
      };
    };
  };
}

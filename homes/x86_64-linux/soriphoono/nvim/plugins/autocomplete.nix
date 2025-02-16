{
  programs.nvf.settings.vim = {
    lsp.lspkind = {
      enable = true;

      setupOpts.mode = "symbol";
    };

    autocomplete = {
      enableSharedCmpSources = true;

      nvim-cmp = {
        enable = true;

        sources = {
          neorg = null;
          codeium = null;
        };
      };
    };
  };
}

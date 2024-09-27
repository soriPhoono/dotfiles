{
  programs.nixvim.plugins = {
    lsp.servers = {
      pyright.enable = true;
      pylsp.enable = true;
    };

    none-ls.sources = {
      diagnostics.pylint.enable = true;
      formatting.isort.enable = true;
    };
  };
}

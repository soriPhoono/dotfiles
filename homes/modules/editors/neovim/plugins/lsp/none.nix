{
  programs.nixvim.plugins = {
    lsp-format = {
      enable = true;
    };

    none-ls = {
      enable = true;

      sources.formatting.nixfmt.enable = true;
    };
  };
}

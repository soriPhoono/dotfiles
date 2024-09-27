{
  programs.nixvim.plugins = {
    cmp-nvim-lsp.enable = true;
    cmp-fuzzy-path.enable = true;
    cmp-fuzzy-buffer.enable = true;
    cmp-vsnip.enable = true;

    cmp = {
      enable = true;

      autoEnableSources = false;

      settings = {
        mapping = {
          "<C-e>" = "cmp.mapping.close()";
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        };
        sources = [
          { name = "vsnip"; }
          { name = "fuzzy_path"; }
          { name = "fuzzy_buffer"; }
          { name = "nvim_lsp"; }
        ];
      };
    };
  };
}

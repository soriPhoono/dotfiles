{
  programs.nixvim.plugins = {
    lsp.servers.ts-ls.enable = true;
    none-ls.sources.formatting.biome.enable = true;
  };
}

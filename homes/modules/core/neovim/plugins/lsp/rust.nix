{
  programs.nixvim.plugins.lsp.servers = {
    taplo.enable = true;
    rust-analyzer = { enable = true; };
  };
}

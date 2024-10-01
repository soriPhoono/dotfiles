{
  programs.nixvim.plugins.lsp.servers.rust-analyzer = {
    enable = true;

    installRustc = true;
    installCargo = true;
  };
}

{
  imports = [ ./nil.nix ./lua.nix ./python.nix ];

  programs.nixvim.plugins = {
    lsp.enable = true;
    lsp-format.enable = true;

    none-ls.enable = true;
  };
}

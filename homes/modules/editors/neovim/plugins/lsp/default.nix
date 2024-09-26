{
  imports = [ ./nil.nix ./lua.nix ];

  programs.nixvim.plugins = {
    lsp.enable = true;
    lsp-format.enable = true;

    none-ls.enable = true;
  };
}

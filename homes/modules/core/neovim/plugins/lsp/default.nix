{
  imports =
    [ ./bash.nix ./nil.nix ./lua.nix ./rust.nix ./python.nix ./javascript.nix ];

  programs.nixvim.plugins = {
    lsp.enable = true;
    lsp-format.enable = true;

    none-ls.enable = true;
  };
}

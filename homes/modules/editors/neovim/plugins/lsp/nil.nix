{
  programs.nixvim.plugins = {
    lsp.servers.nil-ls = {
      enable = true;

      settings.nix.flake = {
        autoArchive = true;
        autoEvalInputs = true;
      };
    };

    none-ls = {
      sources = {
        formatting.nixfmt.enable = true;
        diagnostics.statix.enable = true;
      };
    };
  };
}

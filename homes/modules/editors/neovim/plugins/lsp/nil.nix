{
  programs.nixvim.plugins = {
    lsp.servers.nil-ls = {
      enable = true;

      settings.nix = {
        maxMemoryMB = 5120;
        flake = {
          autoArchive = true;
          autoEvalInputs = true;
        };
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

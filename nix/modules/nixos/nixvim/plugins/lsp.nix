{ ... }: {
  programs.nixvim.plugins = {
    lsp = {
      enable = true;

      servers = {
        nixd = {
          enable = true;

          settings.formatting.command = [
            "nixpkgs-fmt"
          ];
        };

        bashls.enable = true;

        clangd.enable = true;

        zls.enable = true;
        rust_analyzer.enable = true;

        java_language_server.enable = true;

        pylsp.enable = true;

        lua_ls.enable = true;
      };
    };
  };
}

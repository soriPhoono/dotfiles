{
  programs.nvf.settings.vim = {
    lsp = {
      enable = true;
      formatOnSave = true;
      lspkind = {
        enable = true;
        setupOpts.mode = "symbol";
      };
    };

    autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
    };

    languages = {
      enableExtraDiagnostics = true;
      enableFormat = true;
      enableTreesitter = true;

      nix = {
        enable = true;
        lsp.server = "nixd";
      };
      bash.enable = true;
      nu.enable = true;
      lua.enable = true;

      haskell.enable = true;
      clang.enable = true;
      zig.enable = true;
      rust = {
        enable = true;
        crates.enable = true;
      };

      csharp.enable = true;
      java.enable = true;

      python = {
        enable = true;
        format.type = "black-and-isort";
        lsp.server = "python-lsp-server";
      };

      kotlin.enable = true;
      dart = {
        enable = true;
        flutter-tools = {
          enable = true;
          color = {
            enable = true;
            virtualText.enable = true;
          };
        };
      };

      go.enable = true;
      sql.enable = true;

      html.enable = true;
      css.enable = true;
      ts = {
        enable = true;
        extensions.ts-error-translator.enable = true;
      };
      php.enable = true;

      markdown = {
        enable = true;
        extensions = {
          markview-nvim.enable = true;
        };
      };

      yaml.enable = true;
    };
  };
}

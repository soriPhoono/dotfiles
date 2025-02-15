{pkgs, ...}: {
  programs.nvf.settings.vim.languages = {
    enableDAP = true;
    enableExtraDiagnostics = true;
    enableFormat = true;
    enableLSP = true;
    enableTreesitter = true;

    # System admin languages
    nix = {
      enable = true;
      extraDiagnostics.enable = true;
      lsp.package = pkgs.nixd;
    };

    terraform.enable = true;
    bash.enable = true;
    nu.enable = true;

    # Compiled desktop languages
    clang = {
      enable = true;
      cHeader = true;
    };
    lua = {
      enable = true;
      lsp.lazydev.enable = true;
    };
    zig.enable = true;
    rust = {
      enable = true;
      crates = {
        enable = true;
        codeActions = true;
      };
    };
    wgsl.enable = true;

    java.enable = true;

    haskell.enable = true;
    go.enable = true;
    php.enable = true;

    python.enable = true;

    html.enable = true;
    css.enable = true;
    ts.enable = true;
    svelte.enable = true;
    sql.enable = true;

    markdown.enable = true;
  };
}

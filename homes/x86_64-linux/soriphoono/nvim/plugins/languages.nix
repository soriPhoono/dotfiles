{
  programs.nvf.settings.vim.languages = {
    enableDAP = true;
    enableExtraDiagnostics = true;
    enableFormat = true;
    enableLSP = true;
    enableTreesitter = true;

    nix.enable = true;
    terraform.enable = true;
    bash.enable = true;
    nu.enable = true;

    clang.enable = true;
    lua.enable = true;
    zig.enable = true;
    rust.enable = true;
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

{
  opts = {
    foldenable = false;
    foldmethod = "expr";
    foldexpr = "v:lua.vim.treesitter.foldexpr()";
  };

  plugins = {
    treesitter-context.enable = true;
    ts-context-commentstring.enable = true;

    treesitter = {
      enable = true;

      settings = {
        highlight = {
          enable = true;
          additional_vim_regex_highlighting = true;
        };
        indent.enable = true;
      };
    };
  };
}

{ ... }: {
  programs.nixvim.plugins = {
    treesitter-context.enable = true;
    ts-context-commentstring.enable = true;

    treesitter = {
      enable = true;

      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
    };
  };
}

{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

      settings.highlight.enable = true;
    };

    treesitter-context = {
      enable = true;

      settings = { line-numbers = false; };
    };
  };
}

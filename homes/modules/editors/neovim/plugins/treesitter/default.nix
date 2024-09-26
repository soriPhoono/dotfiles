{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

      nixvimInjections = true;
    };

    treesitter-context = {
      enable = true;

      settings = { line-numbers = false; };
    };
  };
}

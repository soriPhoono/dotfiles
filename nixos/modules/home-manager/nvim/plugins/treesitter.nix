{ ... }: {
  programs.nixvim.plugins = {
    hmts.enable = true;

    treesitter = {
      enable = true;

      nixGrammars = true;
      nixvimInjections = true;

      folding = true;
      indent = true;

      incrementalSelection.enable = true;
    };

    treesitter-refactor = {
      enable = true;
      highlightDefinitions = {
        enable = true;

        clearOnCursorMove = false;
      };
    };

    treesitter-context = {
      enable = true;
      settings.max_lines = 2;
    };

    rainbow_delimiters.enable = true;
  };
}

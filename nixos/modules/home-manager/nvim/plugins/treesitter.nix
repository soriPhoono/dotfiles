{ ... }: {
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

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

    hmts.enable = true;
  };
}

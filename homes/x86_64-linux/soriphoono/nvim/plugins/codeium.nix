{pkgs, ...}: {
  programs.nvf.settings.vim.lazy.plugins = {
    codeium = {
      package = pkgs.vimPlugins.codeium-nvim;
      event = ["LspAttach"];
      setup =
        # Lua
        ''
          require(\'codeium\').setup({})
        '';
    };
  };
}

{pkgs, ...}: {
  programs.nvf.settings.vim.lazy.plugins = {
    "codeium.nvim" = {
      package = pkgs.vimPlugins.codeium-nvim;
      setupModule = "codeium";
      event = ["LspAttach"];
    };
  };
}

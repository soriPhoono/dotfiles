{ inputs, ... }: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes.catppuccin = {
      enable = true;

      settings = {
        flavour = "mocha";

        transparent_background = true;
      };
    };

    editorconfig.enable = true;

    plugins = {
      neo-tree = {
        enable = true;

        popupBorderStyle = "rounded";
      };
      telescope = {
        enable = true;

        extensions = {
          file-browser.enable = true;
          fzf-native.enable = true;
        };
      };
      treesitter.enable = true;
      lsp.enable = true;
      cmp.enable = true;
      cmp-buffer.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-treesitter.enable = true;
    };
  };
}

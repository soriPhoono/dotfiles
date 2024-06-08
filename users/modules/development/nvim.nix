{ inputs, ... }: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;
    enableMan = true;
    
    colorschemes.catppuccin.enable = true;

    plugins = {
      lualine.enable = true;
      surround.enable = true;
      telescope.enable = true;
      toggleterm.enable = true;
      treesitter.enable = true;

      nix.enable = true;
      zigvim.enable = true;
    };
  };
}
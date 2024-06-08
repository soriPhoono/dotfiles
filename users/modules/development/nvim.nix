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
      toggleterm.enable = true;
      telescope.enable = true;

      cmp.enable = true;
      treesitter.enable = true;
      surround.enable = true;

      nix.enable = true;
      zig.enable = true;
    };
  };
}
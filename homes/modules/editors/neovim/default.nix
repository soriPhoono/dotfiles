{ inputs
, ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  home.shellAliases.v = "nvim";

  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin.enable = true;

    globals.mapleader = " ";
    globals.maplocalleader = ",";

    plugins = {
      telescope.enable = true;
    };
  };
}

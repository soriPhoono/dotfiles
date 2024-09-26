{ inputs
, ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./plugins/telescope.nix
    ./plugins/treesitter.nix
    ./plugins/fugitive.nix
  ];

  home.shellAliases.v = "nvim";

  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin.enable = true;

    globals.mapleader = " ";
    globals.maplocalleader = ",";
  };
}

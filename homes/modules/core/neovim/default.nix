{ inputs, ... }: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./config/keymap.nix
    ./config/opts.nix
    ./plugins
  ];

  home.shellAliases.v = "nvim";

  programs.nixvim = {
    enable = true;

    defaultEditor = true;

    colorschemes.catppuccin.enable = true;

    globals.mapleader = " ";
  };
}

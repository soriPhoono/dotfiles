{ inputs, lib, config, ... }:
let cfg = config.core.programs.neovim;
in {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./config/keymap.nix
    ./config/opts.nix
    ./plugins
  ];

  options = {
    core.programs.neovim.enable = lib.mkEnableOption "Enable neovim support";
  };

  config = lib.mkIf cfg.enable {
    home.shellAliases.v = "nvim";

    programs.nixvim = {
      enable = true;

      defaultEditor = true;

      colorschemes.catppuccin.enable = true;

      globals.mapleader = " ";
    };
  };
}

{ inputs, ... }: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./options.nix
    ./keymaps.nix
    ./autocmd.nix

    ./plugins
  ];

  home.shellAliases.v = "nvim";

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;

    globals = {
      loaded_ruby_provider = 0;
      loaded_perl_provider = 0;
      loaded_python_provider = 0;

      mapleader = " ";
      maplocalleader = " ";
    };

    colorschemes.catppuccin = {
      enable = true;

      settings.transparent_background = true;
    };

    highlight = {
      Todo = {
        fg = "Yellow";
        bg = "White";
      };
    };

    match = { TODO = "TODO"; };

    editorconfig.enable = true;
  };
}

{ inputs, ... }: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;

      settings = {
        flavour = "mocha";

        transparent_background = true;
      };
    };

    editorconfig.enable = true;


  };
}

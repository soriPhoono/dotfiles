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


  };
}

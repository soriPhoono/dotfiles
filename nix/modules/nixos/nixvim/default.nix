{ ... }: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes.catppuccin = {
      enable = true;

      settings.flavor = "mocha";
    };
  };
}

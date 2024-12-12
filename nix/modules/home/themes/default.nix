{ ... }: {
  stylix = {
    enable = true;

    targets = {
      nixvim.enable = false;
      neovim.enable = false;
    };
  };
}

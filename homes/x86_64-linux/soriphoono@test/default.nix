{ inputs, ... }: {
  imports = [
    inputs.nvim.homeModules.default
  ];

  core.git = {
    userName = "soriphoono";
    userEmail = "soriphoono@gmail.com";
  };

  stylix = {
    enable = true;

    targets = {
      nixvim.enable = false;
      neovim.enable = false;
    };
  };
}

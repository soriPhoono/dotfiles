{ inputs, ... }: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    editorconfig.enable = true;
  };
}

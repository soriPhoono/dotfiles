{ inputs, ... }: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./config
    ./plugins
  ];

  home.shellAliases.v = "nvim";

  programs.nixvim.enable = true;
}

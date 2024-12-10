{ ... }: {
  imports = [
    ./ui.nix
    ./utility.nix

    ./lsp.nix
  ];

  programs.nixvim.plugins.web-devicons.enable = true;
}

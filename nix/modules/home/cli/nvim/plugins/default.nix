{ ... }: {
  imports = [
    ./ui.nix
    ./ide_utilities.nix
    ./lsp.nix
    ./notes_utilities.nix
  ];

  programs.nixvim.plugins = {
    web-devicons.enable = true;
    transparent.enable = true;
  };
}

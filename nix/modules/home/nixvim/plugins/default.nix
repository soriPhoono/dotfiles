{ ... }: {
  imports = [
    ./noice.nix
    ./lualine.nix
    ./neotree.nix

    ./cmp.nix
    ./lsp.nix
  ];

  programs.nixvim.plugins = {
    gitsigns.enable = true;
    autoclose.enable = true;

    toggleterm = {
      enable = true;
      settings.direction = "float";
    };

    which-key = {
      enable = true;

      settings.preset = "helix";
    };
  };
}

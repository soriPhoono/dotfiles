{ ... }: {
  imports = [
    ./noice.nix
    ./treesitter.nix
    ./lualine.nix
    ./telescope.nix

    ./cmp.nix
    ./lsp.nix
  ];

  programs.nixvim = {
    plugins = {
      autoclose.enable = true;
      commentary.enable = true;
      gitsigns.enable = true;
      lazygit.enable = true;

      which-key = {
        enable = true;

        settings.preset = "helix";
      };

      dashboard = {
        enable = true;

        settings.theme = "hyper";
      };
    };
  };
}
{ ... }: {
  imports = [
    ./noice.nix
    ./treesitter.nix
    ./lualine.nix
    ./telescope.nix
    ./neo-tree.nix

    ./cmp.nix
    ./lsp.nix
  ];

  programs.nixvim = {
    keymap = [
      {
        action = "<cmd>IncRename<CR>";
        key = "<F2>";
        options = {
          silent = true;
          desc = "Rename element under cursor";
        };
      }
    ];

    plugins = {
      autoclose.enable = true;
      commentary.enable = true;
      gitsigns.enable = true;
      lazygit.enable = true;
      codeium-nvim.enable = true;
      inc-rename.enable = true;

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

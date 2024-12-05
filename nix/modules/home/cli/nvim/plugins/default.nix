{ ... }: {
  imports = [
    ./noice.nix
    ./treesitter.nix
    ./lualine.nix
    ./neotree.nix
    ./telescope.nix
    ./trouble.nix

    ./cmp.nix
    ./lsp.nix
  ];

  programs.nixvim = {
    keymaps = [
      {
        action = "<cmd>ToggleTerm<CR>";
        key = "<leader>t";
        options = {
          silent = true;
          desc = "Open internal terminal";
        };
      }
    ];

    plugins = {
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

      dashboard = {
        enable = true;

        settings.theme = "hyper";
      };
    };
  };
}

{
  imports = [
    ./treesitter.nix

    ./neo-tree.nix
    ./telescope.nix
  ];

  programs.nixvim = {
    keymaps = [
      {
        action = "<cmd>Commentary<CR>";
        key = "<leader>c";
        mode = [ "n" ];
        options = {
          silent = true;
        };
      }
    ];

    plugins = {
      commentary.enable = true;
      gitgutter.enable = true;
      which-key.enable = true;
    };
  };
}

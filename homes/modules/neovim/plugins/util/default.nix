{
  imports =
    [ ./commentary.nix ./autopairs.nix ./gitsigns.nix ./toggleterm.nix ];

  programs.nixvim = {
    keymaps = builtins.map (v: v // { options.silent = true; }) [{
      key = "<leader>g";
      action = "<cmd>LazyGit<CR>";
      mode = [ "n" ];
      options.desc = "Open LazyGit";
    }];

    plugins = {
      lazygit.enable = true;
      inc-rename.enable = true;
    };
  };
}

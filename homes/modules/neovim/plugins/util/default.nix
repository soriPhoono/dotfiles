{
  imports =
    [ ./commentary.nix ./autopairs.nix ./gitsigns.nix ./toggleterm.nix ];

  programs.nixvim = {
    keymaps = builtins.map (v: v // { options.silent = true; }) [
      {
        key = "<leader>g";
        action = "<cmd>LazyGit<CR>";
        mode = [ "n" ];
        options.desc = "Open LazyGit";
      }
      {
        key = "<F2>";
        action = "<cmd>IncRename <cword><CR>";
        mode = [ "n" ];
        options.desc = "Rename current token";
      }
    ];

    plugins = {
      lazygit.enable = true;
      inc-rename.enable = true;
    };
  };
}

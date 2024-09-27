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
        action =
          # lua
          ''
            function()
              return ":IncRename " .. vim.fn.expand("<cword>")
            end
          '';
        mode = [ "n" ];
        options = {
          desc = "Rename current token";
          expr = true;
        };
      }
    ];

    plugins = {
      lazygit.enable = true;
      inc-rename.enable = true;
    };
  };
}

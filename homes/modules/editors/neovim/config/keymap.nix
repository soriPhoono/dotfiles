{
  programs.nixvim.keymaps =
    builtins.mapAttrs (n: v: v // { options.silent = true; }) [
      {
        key = "<leader>ww";
        action = "<cmd>write<CR>";
        mode = [ "n" ];
        options.desc = "Save to disk";
      }
      {
        key = "<leader>wq";
        action = "<cmd>wq<CR>";
        mode = [ "n" ];
        options.desc = "Save and quit";
      }
    ];
}

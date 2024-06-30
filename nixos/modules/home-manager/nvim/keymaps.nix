{ lib, config, ... }: {
  programs.nixvim.keymaps = let
    base_map = lib.mapAttrsToList (key: action: {
      mode = "n";
      inherit action key;
    }) {
      # clear search history via esc
      "<esc>" = ":noh<CR>";

      # close via ctrl-q, save via ctrl-s
      "<C-q>" = ":qa<CR>";
      "<leader>q" = ":bdelete<CR>";
      "<leader>w" = ":w<CR>";

      # navigate to left/right window
      "<leader>Left" = "<C-w>h";
      "<leader>Right" = "<C-w>l";

      # resize with arrows
      "<C-Up>" = ":resize -2<CR>";
      "<C-Down>" = ":resize +2<CR>";
      "<C-Left>" = ":vertical resize +2<CR>";
      "<C-Right>" = ":vertical resize -2<CR>";

      # move current line up/down
      # M = Alt key
      "<M-Up>" = ":move-2<CR>";
      "<M-Down>" = ":move+<CR>";
    };
  in config.nixvim.helpers.keymaps.mkKeymaps { options.silent = true; }
  base_map;
}

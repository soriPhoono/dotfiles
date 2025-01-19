{
  programs.nixvim.keymaps =
    builtins.map
    (v: v // {options.silent = true;})
    [
      {
        action = "<cmd>w<CR>";
        key = "<C-s>";
        options.desc = "Close current file or editor";
      }
      {
        action = "<cmd>qall<CR>";
        key = "<C-q>";
        options.desc = "Close the editor";
      }
    ];
}

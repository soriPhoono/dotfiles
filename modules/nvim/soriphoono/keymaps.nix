{
  keymaps =
    builtins.map
    (v: v // {options.silent = true;})
    [
      {
        action = "<cmd>w<CR>";
        key = "<C-s>";
        options.desc = "Save current file";
      }
      {
        action = "<cmd>qall<CR>";
        key = "<C-q>";
        options.desc = "Close the editor";
      }
    ];
}

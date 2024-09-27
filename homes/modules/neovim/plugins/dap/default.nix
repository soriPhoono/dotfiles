{
  imports = [ ./adapters ];

  programs.nixvim = {
    keymaps = builtins.map (v: v // { options.silent = true; }) [
      {
        key = "<F5>";
        action = "<cmd>DapContinue<CR>";
        mode = [ "n" ];
        options.desc = "Continue or activate debugging session";
      }
      {
        key = "<leader>db";
        action = "<cmd>DapToggleBreakpoint<CR>";
        mode = [ "n" ];
        options.desc = "Toggle breakpoint";
      }
      {
        key = "<leader>dso";
        action = "<cmd>DapStepOver";
        mode = [ "n" ];
        options.desc = "Step over symbol";
      }
      {
        key = "<leader>dsi";
        action = "<cmd>DapStepInto";
        mode = [ "n" ];
        options.desc = "Step into symbol";
      }
    ];

    plugins.dap.enable = true;
  };
}

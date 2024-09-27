{
  imports = [ ./adapters ];

  programs.nixvim = {
    keymaps = builtins.map (v: v // { options.silent = true; }) [
      {
        key = "<F5>";
        action = "<cmd>lua require('dapui').open<CR><cmd>DapContinue<CR>";
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

    plugins.dap = {
      enable = true;

      extensions = {
        dap-ui = {
          enable = true;

          layouts = [
            {
              elements = [
                {
                  id = "scopes";
                  size = 0.25;
                }
                {
                  id = "breakpoints";
                  size = 0.25;
                }
                {
                  id = "stacks";
                  size = 0.25;
                }
                {
                  id = "watches";
                  size = 0.25;
                }
              ];
              position = "left";
              size = 40;
            }
            {
              elements = [
                {
                  id = "repl";
                  size = 0.5;
                }
                {
                  id = "console";
                  size = 0.5;
                }
              ];
              position = "bottom";
              size = 10;
            }
          ];

          mappings = {
            edit = "<leader>de";
            expand = "<CR>";
            open = "<leader>do";
            remove = "<leader>dd";
            repl = "<leader>dr";
            toggle = "<leader>dt";
          };
        };
      };
    };
  };
}

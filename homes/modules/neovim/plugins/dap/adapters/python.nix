{
  programs.nixvim.plugins.dap = {
    adapters.executables."python" = {
      command = "python";
      args = [ "%" ];
    };

    configurations."python" = [{
      name = "Launch python executable";
      request = "launch";
      type = "python";
    }];
  };
}

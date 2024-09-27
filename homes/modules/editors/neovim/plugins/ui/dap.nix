{
  programs.nixvim.plugins.dap = {
    enable = true;

    adapters.executables = {
      "nix" = {
        command = "nix";
        args = [ "flake" "check" ];
      };
    };

    configurations."nix" = [{
      name = "Check nix flake";
      request = "launch";
      type = "nix";
    }];

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
      };
    };
  };
}

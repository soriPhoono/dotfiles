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

            ];
            position = "left";
            size = 40;
          }
          {
            elements = [
              # TODO: finish this
            ];
            position = "bottom";
            size = 10;
          }
        ];
      };
    };
  };
}

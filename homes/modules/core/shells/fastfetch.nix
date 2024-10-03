{ lib, config, ... }:
let cfg = config.core.shells;
in {
  options = {
    core.shells.fastfetch.enable = lib.mkEnableOption "Enable fastfetch";
  };

  config = lib.mkIf cfg.enable {
    programs.fastfetch = {
      enable = true;

      settings = {
        logo = {
          source = ../assets/fastfetch.txt;
          color = { "1" = "cyan"; };

          padding = { right = 1; };
        };

        display = {
          size = { binaryPrefix = "si"; };

          color = "cyan";
          separator = "  ";
        };

        modules = [
          {
            type = "datetime";
            key = "Date";
            format = "{1}-{3}-{11}";
          }
          {
            type = "datetime";
            key = "Time";
            format = "{14}:{17}:{20}";
          }

          "break"
          "os"
          "wm"
          {
            type = "users";
            key = "User";
            myselfOnly = true;
          }
          {
            type = "cpu";
            key = "CPU";
            temp = true;
          }
          {
            type = "gpu";
            key = "GPU";
            temp = true;
          }
        ];
      };
    };

    core.shells.fish.extraShellInit =
      lib.mkIf config.core.shells.fish.enable "fastfetch";
  };
}

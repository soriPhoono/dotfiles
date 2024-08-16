{ lib, config, ... }:
let cfg = config.terminal.editors.helix;
in {
  options = {
    terminal.editors.helix.enable = lib.mkEnableOption "Enable helix editor";
  };

  config = lib.mkIf cfg.enable {
    helix = {
      enable = true;
      defaultEditor = true;

      settings = {
        editor = {
          auto-save = true;

          statusline = {
            left = [
              "mode"
              "version-control"
              "file-base-name"
              "file-modification-indicator"
            ];
            right = [ "diagnostics" "file-type" "position-percentage" ];

            mode = {
              normal = "󰋜";
              insert = "󰏪";
              select = "󰍉";
            };
          };

          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
        };
      };
    };
  };
}

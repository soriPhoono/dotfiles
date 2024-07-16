{
  programs = {
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

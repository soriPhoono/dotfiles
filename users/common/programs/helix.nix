{ pkgs, ... }: {
  programs = {
    helix = {
      enable = true;
      defaultEditor = true;

      ignores = [ ];

      settings = {
        languages = with pkgs; {
          nix-language-server = {
            command = "${nil}/bin/nil";
            args = [ "--stdio" ];
          };

          language = [{
            name = "nix";
            formatter = {
              command = "${nixpkgs-fmt}/bin/nixpkgs-fmt";
              args = [ ];
            };
          }];
        };

        editor = {
          auto-save = true;

          bufferline = "multiple";

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

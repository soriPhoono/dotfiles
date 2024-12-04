{ pkgs, ... }: {
  programs.helix = {
    enable = true;
    defaultEditor = true;

    languages = with pkgs; {
      language-server.nixd = {
        command = "${nixd}/bin/nixd";
      };

      language = [
        {
          name = "nix";
          language-servers = [
            "nixd"
          ];
          formatter = {
            command = "${nixpkgs-fmt}/bin/nixpkgs-fmt";
          };
        }
      ];
    };

    settings = {
      editor = {
        cursor-shape = {
          normal = "bar";
          insert = "bar";
          select = "bar";
        };
      };
      keys = {
        normal = {
          space.w = ":w";
          space.q = ":q";
        };
      };
    };
  };
}

{ ... }:
let
  colors = {
    blue = "#89b4fa";
    cyan = "#89dceb";
    black = "#11111b";
    white = "#cdd6f4";
    red = "#f38ba8";
    violet = "#f38ba8";
    grey = "#313244";
  };
in
{
  programs.nixvim.plugins = {
    lualine = {
      enable = true;

      settings = {
        options = {
          theme = {
            normal = {
              a = {
                fg = colors.black;
                bg = colors.violet;
              };
              b = {
                fg = colors.white;
                bg = colors.grey;
              };
              c = {
                fg = colors.white;
              };
            };

            insert = {
              a = {
                fg = colors.black;
                bg = colors.blue;
              };
            };

            visual = {
              a = {
                fg = colors.black;
                bg = colors.cyan;
              };
            };

            replace = {
              a = {
                fg = colors.black;
                bg = colors.red;
              };
            };

            inactive = {
              a = {
                fg = colors.white;
                bg = colors.black;
              };
              b = {
                fg = colors.white;
                bg = colors.black;
              };
              c = {
                fg = colors.white;
              };
            };
          };
        };

        sections = {
          lualine_a = [
            "mode"
          ];
          lualine_b = [
            "filename" "branch"
          ];
          lualine_c = [];
          lualine_x = [];
          lualine_y = [
            "filetype" "progress"
          ];
          lualine_z = [
            "location"
          ];
        };

        inactive_sections = {
          lualine_a = [
            "filename"
          ];
          lualine_z = [
            "location"
          ];
        };
      };
    };
  };
}

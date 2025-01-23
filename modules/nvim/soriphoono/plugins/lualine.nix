{
  plugins.lualine = let
    colors = {
      blue = "#89b4fa";
      cyan = "#89dceb";
      black = "#11111b";
      white = "#cdd6f4";
      red = "#f38ba8";
      violet = "#cba6f7";
      grey = "#313244";
    };
  in {
    enable = true;

    settings = {
      sections = {
        lualine_a = [
          "mode"
        ];
        lualine_b = [
          "branch"
        ];
        lualine_c = [
        ];
        lualine_x = [
          "fileformat"
          "filetype"
        ];
        lualine_y = [
          "diagnostics"
        ];
        lualine_z = [
          "encoding"
        ];
      };
      inactive_sections = {
        lualine_a = [
        ];
        lualine_b = [
        ];
        lualine_c = [
          "filename"
        ];
        lualine_x = [
          "location"
        ];
        lualine_y = [
        ];
        lualine_z = [
        ];
      };
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
    };
  };
}

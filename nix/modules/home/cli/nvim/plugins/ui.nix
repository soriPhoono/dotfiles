{ ... }: {
  programs.nixvim.plugins = {
    transparent.enable = true;

    notify = {
      enable = true;
      render = "compact";
    };

    which-key = {
      enable = true;
      settings.preset = "helix";
    };

    noice = {
      enable = true;

      settings = {
        presets = {
          bottom_search = true;
          command_palette = true;
          inc_rename = true;
          long_message_to_split = false;
          lsp_doc_border = true;
        };

        lsp.override = {
          "cmp.entry.get_documentation" = true;
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
        };
      };
    };

    lualine =
      let
        colors = {
          blue = "#89b4fa";
          cyan = "#89dceb";
          black = "#11111b";
          white = "#cdd6f4";
          red = "#f38ba8";
          violet = "#cba6f7";
          grey = "#313244";
        };
      in
      {
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
        };
      };
  };
}

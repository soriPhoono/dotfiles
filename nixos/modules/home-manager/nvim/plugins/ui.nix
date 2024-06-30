{ lib, config, ... }: {
  programs.nixvim = {
    keymaps = let
      ui_map = lib.mapAttrsToList (key: action: {
        mode = "n";
        inherit action key;
      }) {
        # Core windows
        "<leader>e" = ":Neotree reveal toggle<CR>";
        "<leader>t" = ":TagbarToggle<CR>";
      };
    in config.nixvim.helpers.keymaps.mkKeymaps { options.silent = true; }
    ui_map;

    plugins = {
      fidget = {
        enable = true;

        notification.window = {
          align = "top";

          border = [ "╭" "─" "╮" "│" " " "│" "╰" "─" "╯" ];
        };

        progress = {
          suppressOnInsert = true;
          ignoreDoneAlready = true;
          pollRate = 0.5;
        };
      };

      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
        };
      };

      lualine = {
        enable = true;

        globalstatus = true;

        # +-------------------------------------------------+
        # | A | B | C                             X | Y | Z |
        # +-------------------------------------------------+
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [ "branch" ];
          lualine_c = [ "filename" "diff" ];

          lualine_x = [
            "diagnostics"

            # Show active language server
            {
              name.__raw = ''
                function()
                    local msg = ""
                    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                    local clients = vim.lsp.get_active_clients()
                    if next(clients) == nil then
                        return msg
                    end
                    for _, client in ipairs(clients) do
                        local filetypes = client.config.filetypes
                        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                            return client.name
                        end
                    end
                    return msg
                end
              '';
              icon = "";
              color.fg = "#ffffff";
            }
            "encoding"
            "fileformat"
            "filetype"
          ];
        };
      };

      bufferline = {
        enable = true;
        hover = {
          enabled = true;

          reveal = [ "close" ];
        };

        highlights = {
          bufferSelected = {
            underline = true;
            italic = true;
          };
        };

        offsets = [{
          filetype = "neo-tree";
          text = "File Explorer";
          highlight = "Directory";
          separator = true;
        }];

        separatorStyle = "slant";

        diagnostics = "nvim_lsp";
        diagnosticsIndicator = ''
          function(count, level, diagnostics_dict, context)
              if context.buffer:current() then
                  return ""
              end
              local s = " "
              for e, n in pairs(diagnostics_dict) do
                  local sym = e == "error" and " "
                  or (e == "warning" and " " or "" )
                  s = s .. n .. sym
              end
              return s
          end
        '';
      };

      neo-tree = {
        enable = true;

        closeIfLastWindow = true;

        window = {
          width = 30;
          autoExpandWidth = true;
        };
      };

      floaterm = {
        enable = true;
        giteditor = true;

        autoclose = 2;

        width = 0.8;
        height = 0.8;

        title = "";

        keymaps.toggle = "<leader>,";
      };

      telescope = {
        enable = true;

        keymaps = {
          # Find files using Telescope command-line sugar.
          "<leader>f" = "find_files";
          "<leader>g" = "live_grep";
          "<leader>b" = "buffers";
          "<leader>h" = "help_tags";
          "<leader>d" = "diagnostics";
        };

        settings.defaults = {
          file_ignore_patterns = [
            "^.git/"
            "^.mypy_cache/"
            "^__pycache__/"
            "^output/"
            "^data/"
            "%.ipynb"
          ];
          set_env.COLORTERM = "truecolor";
        };

        extensions.fzf-native = { enable = true; };
      };

      tagbar = {
        enable = true;
        settings = {
          autoclose = true;
          autofocus = false;
          autoshowtag = true;

          foldlevel = 2;

          width = 50;
        };
      };

      copilot-chat.enable = true;

      trouble.enable = true;

      which-key.enable = true;

      wilder = {
        enable = true;
        modes = [ ":" "/" "?" ];
      };

      startify = {
        enable = true;

        settings = {
          custom_header = [
            ""
            "     ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
            "     ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
            "     ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
            "     ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
            "     ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
            "     ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
          ];

          # When opening a file or bookmark, change to its directory.
          change_to_dir = false;

          # By default, the fortune header uses ASCII characters, because they work for everyone.
          # If you set this option to 1 and your 'encoding' is "utf-8", Unicode box-drawing characters will
          # be used instead.
          use_unicode = true;

          lists = [{ type = "dir"; }];
          files_number = 30;

          skiplist = [ "flake.lock" ];
        };
      };
    };
  };
}

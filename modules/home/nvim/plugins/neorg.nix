{
  programs.nixvim.plugins.neorg = {
    enable = true;
    modules = {
      "core.defaults" = {
        __empty = null;
      };
      "core.completion" = {
        config = {
          engine = "nvim-cmp";
          name = "[Norg]";
        };
      };
      "core.integrations.nvim-cmp" = {
        __empty = null;
      };
      "core.concealer" = {
        config = {
          icon_present = "diamond";
        };
      };
      "core.keybinds" = {
        config = {
          default_keybinds = true;
          neorg_leader = "<leader><leader>";
        };
      };
      "core.dirman" = {
        config = {
          workspaces = {
            Notes = "~/Documents/notes/";
          };
        };
      };
      "core.esupports.metagen" = {
        config = {
          type = "auto";
          update_data = true;
        };
      };
      "core.qol.toc" = {
        __empty = null;
      };
      "core.qol.todo_items" = {
        __empty = null;
      };
      "core.looking-glass" = {
        __empty = null;
      };
      "core.presenter" = {
        config = {
          zen_mode = "zen-mode";
        };
      };
      "core.export" = {
        __empty = null;
      };
      "core.export.markdown" = {
        config = {
          extensions = "all";
        };
      };
      "core.summary" = {
        __empty = null;
      };
      "core.tangle" = {
        config = {
          report_on_empty = false;
        };
      };
      "core.ui.calendar" = {
        __empty = null;
      };
      "core.journal" = {
        config = {
          strategy = "flat";
          workspace = "Notes";
        };
      };
    };
  };
}

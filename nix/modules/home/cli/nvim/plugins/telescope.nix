{ ... }: {
  programs.nixvim.plugins = {
    web-devicons.enable = true;
    telescope = {
      enable = true;

      keymaps = {
        "<leader>f" = "git_files";
        "<leader>g" = "live_grep";
      };

      settings = {
        defaults = {
          path_display = [
            "truncate"
          ];
          preview = {
            treesitter = true;
          };
          color_devicons = true;
          prompt_prefix = "";
          selection_caret = " ";
          entry_prefix = " ";
          initial_mode = "insert";
          vimgrep_arguments = [
            "rg"
            "-L"
            "--color=never"
            "--no-heading"
            "--with-filename"
            "--line-number"
            "--column"
            "--smart-case"
          ];
        };
      };
    };
  };
}

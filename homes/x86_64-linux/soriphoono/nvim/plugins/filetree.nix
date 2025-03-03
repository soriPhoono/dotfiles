{
  programs.nvf.settings.vim = {
    keymaps = [
      {
        key = "\\";
        mode = "n";
        silent = true;
        action = "<CMD>Neotree toggle<CR>";
      }
    ];
    filetree = {
      neo-tree = {
        enable = true;

        setupOpts = {
          enable_cursor_hijack = true;
          auto_clean_after_session_restore = true;
          git_status_async = true;
          hide_root_node = true;
        };
      };
    };
  };
}

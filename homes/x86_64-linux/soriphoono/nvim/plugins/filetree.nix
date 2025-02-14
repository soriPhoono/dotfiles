{
  programs.nvf.settings.vim.filetree = {
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
}

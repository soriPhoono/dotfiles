{
  programs.zellij = {
    enable = true;

    settings = {
      simplified_ui = true;

      ui = {
        pane_frames = {
          rounded_corners = true;
          hide_session_name = true;
        };
      };
    };
  };
}

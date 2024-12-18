{ config, ... }:
let
in {
  home.file = { };

  programs.zellij = {
    enable = true;

    enableBashIntegration = true;
    enableFishIntegration = config.cli.fish.enable;

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

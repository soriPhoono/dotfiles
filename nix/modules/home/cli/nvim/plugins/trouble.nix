{ ... }: {
  programs.nixvim.plugins.trouble = {
    enable = true;

    settings = {
      auto_close = true;
      auto_refresh = true;
    };
  };
}

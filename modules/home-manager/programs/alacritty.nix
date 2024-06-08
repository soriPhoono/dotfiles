{ ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      cursor = {
        style = "Beam";
        thickness = 0.25;
      };
      window = {
        padding = {
          x = 10;
        };
      };
    };
  };
}

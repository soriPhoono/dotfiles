{ ... }: {
  programs.nixvim.plugins = {
    web-devicons.enable = true;
    neo-tree = {
      enable = true;
      closeIfLastWindow = true;

      window.position = "left";
    };
  };
}

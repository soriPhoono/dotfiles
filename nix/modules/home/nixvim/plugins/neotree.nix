{ ... }: {
  programs.nixvim.plugins = {
    neo-tree = {
      enable = true;
      closeIfLastWindow = true;

      window.position = "left";
    };
  };
}

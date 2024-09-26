{
  programs.nixvim.plugins = {
    neo-tree = {
      enable = true;

      autoCleanAfterSessionRestore = true;
      closeIfLastWindow = true;
    };
  };
}

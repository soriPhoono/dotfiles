{
  system = {
    boot = {
      enable = true;
      verbose = true;
    };

    vm.virtualbox.enable = true;

    networking.network-manager = true;
  };

  themes.catppuccin.enable = true;
}

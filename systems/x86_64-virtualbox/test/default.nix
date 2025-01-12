{
  system = {
    hardware.vm.virtualbox.enable = true;
  };

  imports = [
    ../../x86_64-linux/test/default.nix
  ];
}

{
  system = {
    hardware.vm.virtualbox.enable = true;

    boot = {
      enable = true;
      plymouth.enable = true;
    };

    power.enable = true;
    pipewire.enable = true;
    networking.enable = true;
    bluetooth.enable = true;
  };
}

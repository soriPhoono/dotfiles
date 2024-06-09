{ vars, ... }: {
  imports = [
  ];

  virtualisation.virtualbox.guest = {
    enable = true;
    seamless = true;
    clipboard = true;
    dragAndDrop = true;
  };

  system.stateVersion = "${vars.stateVersion}";
}

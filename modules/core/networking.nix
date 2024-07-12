{
  networking = {
    networkmanager = {
      enable = true;

      wifi.powersave = false;
    };
  };

  users.users.soriphoono.extraGroups = [ "networkmanager" ];
}

{ vars, ... }: {
  networking = {
    networkmanager = {
      enable = true;

      wifi = {
        powersave = false;
      };
    };
  };

  users.users.${vars.defaultUser}.extraGroups = [
    "networkmanager"
  ];
}

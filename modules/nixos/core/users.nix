{ pkgs, ... }: {
  security.sudo.wheelNeedsPassword = false;

  programs = {
    fish.enable = true;

    dconf.enable = true;
  };

  users.users = {
    soriphoono = {
      name = "SoriPhoono";
      description = "Sori Phoono";

      isNormalUser = true;
      shell = pkgs.fish;

      extraGroups = [ "wheel" ];
    };
  };
}

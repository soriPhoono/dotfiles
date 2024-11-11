{ pkgs, ... }: {
  security.sudo.wheelNeedsPassword = false;

  programs = {
    fish.enable = true;

    dconf.enable = true;
  };

  users.users = {
    soriphoono = {
      description = "Sori Phoono";

      isNormalUser = true;
      shell = pkgs.fish;

      extraGroups = [ "wheel" ];
    };
  };
}

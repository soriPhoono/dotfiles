{ pkgs
, username
, ...
}: {
  security.sudo.wheelNeedsPassword = false;

  programs = {
    fish.enable = true;

    dconf.enable = true;
  };

  users.users.${username} = {
    name = "${username}";
    description = "Sori Phoono";

    isNormalUser = true;
    shell = pkgs.fish;

    extraGroups = [
      "wheel"
    ];
  };
}

{ pkgs
, username
, ...
}: {
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

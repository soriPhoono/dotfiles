{ pkgs, ... }: {
  users.users.soriphoono = {
    description = "Sori Phoono";
    isNormalUser = true;

    shell = pkgs.fish;

    extraGroups = [
      "wheel"
    ];
  };
}

{ pkgs-stable, ... }: {
  hardware.steam-hardware.enable = true;

  programs = {
    steam = {
      enable = true;
      package = pkgs-stable.steam;

      extest.enable = true;
    };
  };
}

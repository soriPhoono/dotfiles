{ pkgs, ... }: {
  hardware.steam-hardware.enable = true;

  programs = {
    steam = {
      enable = true;
      package = pkgs.steam;

      extest.enable = true;
    };
  };
}

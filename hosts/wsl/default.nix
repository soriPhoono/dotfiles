{ config, pkgs, username, ... }: {
  wsl = {
    enable = true;
    defaultUser = "${username}";
  };

  documentation = {
    enable = false;
    man.enable = false;
    info.enable = false;
    nixos.enable = false;
  };

  programs = {
    nix-ld = {
      enable = true;

      package = pkgs.nix-ld-rs;
    };
  };
}

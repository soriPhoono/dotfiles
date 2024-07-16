{ lib, config, pkgs, ... }: {
  core.cli.enable = true;

  programs.nix-ld = {
    enable = true;

    package = pkgs.nix-ld-rs;
  };
}

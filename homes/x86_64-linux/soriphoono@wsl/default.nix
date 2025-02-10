{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../soriphoono
  ];

  core.impermanence.enable = lib.mkForce false;

  nix.package = pkgs.lix;

  programs.bash.initExtra = ''
    ${pkgs.fish}/bin/fish
  '';
}

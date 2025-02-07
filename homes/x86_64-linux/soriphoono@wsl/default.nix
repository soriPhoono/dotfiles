{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../soriphoono
  ];

  desktop.noir.enable = lib.mkForce false;

  nix.package = pkgs.lix;

  programs.bash.initExtra = ''
    ${pkgs.fish}/bin/fish
  '';
}

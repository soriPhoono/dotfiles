{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../soriphoono
  ];

  desktop.soriphoono.enable = lib.mkForce false;

  nix.package = pkgs.nixVersions.latest;

  programs.bash.initExtra = ''
    ${pkgs.fish}/bin/fish
  '';
}

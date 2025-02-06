{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../soriphoono
  ];

  desktop.noir.enable = lib.mkForce false;

  nix.package = pkgs.nixVersions.latest;

  programs.bash.initExtra = ''
    ${pkgs.fish}/bin/fish
  '';
}

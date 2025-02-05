{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../soriphoono
  ];

  hyprland.soriphoono.enable = lib.mkForce false;

  nix.package = pkgs.nixVersions.latest;

  programs.bash.initExtra = ''
    ${pkgs.fish}/bin/fish
  '';
}

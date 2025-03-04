{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../soriphoono
  ];

  sops.age.keyFile = lib.mkForce "~/.config/sops/age/keys.txt";

  programs.bash.initExtra = ''
    ${pkgs.fish}/bin/fish
  '';
}

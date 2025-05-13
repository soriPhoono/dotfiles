{
  pkgs,
  mkShell,
  ...
}:
mkShell {
  packages = with pkgs; [
    disko
    nixos-facter

    age
    sops
    ssh-to-age
  ];
}

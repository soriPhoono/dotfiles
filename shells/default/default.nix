{
  pkgs,
  mkShell,
  ...
}:
mkShell {
  packages = with pkgs; [
    age
    sops
    ssh-to-age
  ];
}

{
  pkgs,
  mkShell,
  ...
}:
mkShell {
  packages = with pkgs; [
    nixd
    alejandra

    age
    sops
    ssh-to-age
  ];
}

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

    (python3.withPackages (ps:
      with ps; [
        discordpy
      ]))
  ];
}

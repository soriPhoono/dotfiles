{
  inputs,
  pkgs,
  mkShell,
  ...
}:
mkShell {
  packages = with pkgs; [
    age
    sops
    ssh-to-age

    disko

    nixos-facter

    inputs.deploy-rs.packages.${pkgs.system}.default
  ];
}

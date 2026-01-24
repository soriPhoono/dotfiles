{
  pkgs,
  config,
  ...
}:
with pkgs; {
  packages = [
    age
    sops
    ssh-to-age

    disko
    nixos-facter
  ];

  interactive.default.text = ''
    ${config.pre-commit.shellHook}
  '';
}

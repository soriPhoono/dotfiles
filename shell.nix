{
  pkgs,
  config,
  ...
}:
with pkgs;
  mkShell {
    packages = [
      age
      sops
      ssh-to-age

      disko
      nixos-facter
    ];

    shellHook = ''
      ${config.pre-commit.shellHook}
    '';
  }

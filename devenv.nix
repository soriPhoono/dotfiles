{pkgs, ...}: {
  env = {
    RUST_MIN_STACK = 16777216;
  };

  packages = with pkgs; [
    disko

    nixos-facter

    sbctl

    age
    ssh-to-age
    sops
  ];

  git-hooks.hooks = {
    gptcommit.enable = true;

    alejandra.enable = true;
    flake-checker.enable = true;
    statix.enable = true;
    deadnix.enable = true;
  };
}

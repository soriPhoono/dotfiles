{ ... }: {
  imports = [
    ./uefi.nix
    ./zramSwap.nix
    ./tmpfs.nix
  ];
}

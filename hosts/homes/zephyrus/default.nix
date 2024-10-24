{
  imports = [
    ./common.nix

    ./plasma.nix
  ];

  userapps.development.advanced = true;
  userapps.streaming.enable = true;
}

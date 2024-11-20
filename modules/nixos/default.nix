{
  flake.nixosModules.default.imports = [
    ./core
    ./desktop
    ./themes
  ];
}

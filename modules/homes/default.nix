{
  flake.homeManagerModules.default = {
    imports = [
      ./cli
      ./desktop
      ./userapps
    ];
  };
}

{
  flake.homeManagerModules.default = {
    imports = [
      ./cli
      # ./desktop
      ./themes
      # ./userapps
    ];
  };
}

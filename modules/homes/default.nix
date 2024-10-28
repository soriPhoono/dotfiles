{
  flake.homeManagerModules.default = {
    imports = [ ./core ./themes ./userapps ];
  };
}

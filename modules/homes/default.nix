{
  flake.homeManagerModules.default = {
    imports = [ ./core ./desktop ./themes ./userapps ];
  };
}

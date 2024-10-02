{
  flake.nixosModules = {
    default = { imports = [ ./core ./virtualization ./desktop ]; };
  };
}

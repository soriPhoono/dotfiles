{
  flake.nixosModules = {
    default = { imports = [ ./hardware ./core ./virtualization ./desktop ]; };
  };
}

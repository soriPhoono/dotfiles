{
  lib,
  config,
  ...
}:
with lib; {
  imports = [
    ./backends/k3s.nix
  ];

  options.hosting.configuration = mkIf (config.mode == "cluster") {};

  config = mkIf (config.hosting.mode == "cluster") {
    hosting.backend.k3s.enable = true;
  };
}

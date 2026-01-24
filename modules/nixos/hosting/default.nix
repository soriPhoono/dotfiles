{lib, ...}:
with lib; {
  imports = [
    ./single-node.nix
  ];

  options.hosting = {
    mode = mkOption {
      type = with types; nullOr (enum ["single-node" "cluster"]);
      description = "The mode to run hosting services, via single-node based systems or clustering provisioned via k3s kubernetes";
      default = null;
      example = "single-node";
    };
  };
}

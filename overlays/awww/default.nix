{inputs, ...}: final: prev: {
  inherit (inputs.awww.packages.${prev.system}) awww;
}

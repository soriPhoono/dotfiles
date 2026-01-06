{inputs, ...}: final: prev: {
  awww = inputs.awww.packages.${prev.system}.awww;
}

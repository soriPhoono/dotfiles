{
  inputs,
  system,
  ...
}:
inputs.pre-commit-hooks.lib.${system}.run {
  src = ../../.;

  hooks = {
    alejandra.enable = true;
    flake-checker.enable = true;
    statix.enable = true;
  };
}

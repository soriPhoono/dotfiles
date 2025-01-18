{
  inputs,
  system,
  ...
}:
inputs.pre-commit-hooks.lib.${system}.run {
  src = ../../.;

  hooks = {
    gptcommit.enable = true;

    alejandra.enable = true;
    flake-checker.enable = true;
    statix.enable = true;
  };
}

{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [
    (final: prev: {
      neovim = inputs.nvim.packages.${pkgs.system}.hollace;
    })
  ];
}

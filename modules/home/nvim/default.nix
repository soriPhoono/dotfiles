{
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.nvim;
in {
  options.nvim.enable = lib.mkEnableOption "Enable neovim configuration";

  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./core/opts.nix
    ./core/keymaps.nix

    ./plugins/lsp.nix
    ./plugins/treesitter.nix
    ./plugins/cmp.nix

    ./plugins/noice.nix
    ./plugins/dashboard.nix
    ./plugins/lualine.nix
    ./plugins/neotree.nix
    ./plugins/telescope.nix

    ./plugins/util.nix
  ];

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
    };
  };
}

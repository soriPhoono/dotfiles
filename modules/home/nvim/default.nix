{
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.nvim;
in {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./core/opts.nix
    ./core/keymaps.nix

    ./plugins/cmp.nix
    ./plugins/lsp.nix
    ./plugins/lualine.nix
    ./plugins/mini.nix
    ./plugins/neorg.nix
    ./plugins/neotree.nix
    ./plugins/noice.nix
    ./plugins/telescope.nix
    ./plugins/treesitter.nix
    ./plugins/util.nix
  ];

  options.nvim.enable = lib.mkEnableOption "Enable custom neovim ide";

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
    };
  };
}

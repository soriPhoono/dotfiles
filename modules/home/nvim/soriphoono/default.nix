{
  lib,
  config,
  ...
}: let
  cfg = config.nvim.soriphoono;
in {
  imports = [
    ./core/opts.nix
    ./core/keymaps.nix

    ./plugins/cmp.nix
    ./plugins/dashboard.nix
    ./plugins/lsp.nix
    ./plugins/lualine.nix
    ./plugins/neotree.nix
    ./plugins/noice.nix
    ./plugins/telescope.nix
    ./plugins/treesitter.nix
    ./plugins/util.nix
  ];

  options.nvim.soriphoono.enable = lib.mkEnableOption "Enable soriphoono's neovim customisations";

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
    };
  };
}

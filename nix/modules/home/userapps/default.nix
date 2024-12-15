{ lib, pkgs, config, ... }:
let cfg = config.userapps;
in {
  imports = [
    ./development.nix
  ];

  options.userapps.enable = lib.mkEnableOption "Enable userapps";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (
        pkgs.discord.overrideAttrs (_: {
          url = "https://discord.com/api/download?platform=linux&format=tar.gz";
          sha256 = "0njwcnrn2br47dzqvmlazcmf63bblx68775f0kv8djwxfvg977im";
        })
      )

      obsidian
    ];

    programs.firefox = {
      enable = true;

      profiles = {
        default = {
          extensions = with config.nur.repos.rycee.firefox-addons; [
            ublock-origin
            stylus
            darkreader
          ];

          bookmarks = [
            {
              name = "minecraft uuid finder";
              keyword = "minecraft";
              url = "https://mcuuid.net/";
            }
          ];
        };
      };
    };
  };
}

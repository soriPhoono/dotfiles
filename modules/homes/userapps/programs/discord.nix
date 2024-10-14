{ lib, config, ... }:
let cfg = config.userapps.programs.discord;
in {
  options = {
    userapps.programs.discord.enable = lib.mkEnableOption "Enable discord";
  };

  config = lib.mkIf cfg.enable {
    programs.discocss = {
      enable = true;

      css = ''
        @import url("https://catppuccin.github.io/discord/dist/catppuccin-catppuccin-teal.theme.css");
      '';
    };
  };
}

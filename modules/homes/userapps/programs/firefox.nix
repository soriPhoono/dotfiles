{ inputs, lib, config, ... }:
let cfg = config.userapps.programs.firefox;
in {
  imports = [
    inputs.nur.nixosModules.nur
  ];

  options = {
    userapps.programs.firefox = {
      enable = lib.mkEnableOption "Enable firefox";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;

      profiles = {
        default = {
          extensions = with config.nur.repos.rycee.firefox-addons; [
            ublock-origin
          ];
        };
      };
    };
  };
}

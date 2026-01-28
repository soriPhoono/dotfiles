{
  lib,
  config,
  ...
}: let
  cfg = config.userapps.office.onlyoffice;
in {
  options.userapps.office.onlyoffice = {
    enable = lib.mkEnableOption "Enable OnlyOffice";
  };

  config = lib.mkIf cfg.enable {
    programs.onlyoffice = {
      enable = true;
    };
  };
}

{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.shells.nushell;
in {
  options.core.shells.nushell.enable = lib.mkEnableOption "Enable nushell integration";

  config = lib.mkIf cfg.enable {
    programs.nushell = {
      enable = true;

      shellAliases = {
        v = "nvim";
      };

      configFile.text =
        # Nu
        ''
          ${pkgs.fastfetch}/bin/fastfetch
        ''
        ++ lib.mkIf (lib.hasAttr "environment" config.sops.secrets) ''
          def "from env" []: string -> record {
            lines
              | split column '#'
              | get column1
              | filter {($in | str length) > 0}
              | parse "{key}={value}"
              | update value {str trim -c '"'}
              | transpose -r -d
          }

          if (${config.sops.secrets.environment.path} | path exists)
          {
            open ${config.sops.secrets.environment.path} | load-env
          }
        '';
    };
  };
}

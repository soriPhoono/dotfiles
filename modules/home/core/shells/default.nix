{
  lib,
  config,
  ...
}: let
  cfg = config.core.shells;
in {
  imports = [
    ./bash.nix
    ./fish.nix
    ./starship.nix
  ];

  options.core.shells = {
    sessionVariables = lib.mkOption {
      type = with lib.types; attrsOf str;
      default = {};
      description = "Environment variables to set for the user";
      example = {
        Foo = "Hello";
        Bar = "${config.core.shells.sessionVariables.Foo} World!";
      };
    };
  };

  config = {
    home = {
      inherit (cfg) sessionVariables;
    };
  };
}

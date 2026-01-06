{
  lib,
  config,
  ...
}: let
  cfg = config.theme;
in
  with lib; {
    options.theme = {
    };

    config = {
    };
  }

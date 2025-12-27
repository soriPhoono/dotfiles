{
  lib,
  pkgs,
  config,
  ...
}: let cfg = config.environments.hyprland.default;
in with lib; {
  config = mkIf cfg.enable {
    programs.librewolf = let
      ff-ultima = pkgs.fetchFromGitHub {
        owner = "soulhotel";
        repo = "FF-ULTIMA";
        rev = "db84254";
        sha256 = "sha256-z1R0OXJYbJd3G+ncWmp44uYJFaZtZ1Qzz8TbaHZ6BBQ=";
      };
    in {
      profiles.default = {
        extraConfig = builtins.readFile (ff-ultima + "/user.js");
        userChrome = builtins.readFile (ff-ultima + "/userChrome.css");
        userContent = builtins.readFile (ff-ultima + "/userContent.css");
      };
    };
  };
}

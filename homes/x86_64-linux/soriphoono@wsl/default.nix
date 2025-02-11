{
  lib,
  pkgs,
  ...
}: {
  nix = {
    package = pkgs.lix;

    settings.trusted-users = lib.mkForce ["@sudo"];
  };

  programs.bash.initExtra = ''
    ${pkgs.fish}/bin/fish
  '';
}

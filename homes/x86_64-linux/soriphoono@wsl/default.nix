{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../soriphoono
  ];

  nix = {
    package = pkgs.lix;

    settings.trusted-users = ["@sudo"];
  };

  core.impermanence.enable = lib.mkForce false;

  programs.bash.initExtra = ''
    ${pkgs.fish}/bin/fish
  '';
}

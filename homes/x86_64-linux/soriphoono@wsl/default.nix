{pkgs, ...}: {
  imports = [
    ../soriphoono
  ];

  nix.package = pkgs.lix;

  programs.bash.initExtra = ''
    ${pkgs.fish}/bin/fish
  '';
}

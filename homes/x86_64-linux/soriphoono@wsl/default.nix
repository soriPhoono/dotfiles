{pkgs, ...}: {
  imports = [
    ../soriphoono
  ];

  programs.bash.initExtra = ''
    ${pkgs.fish}/bin/fish
  '';
}

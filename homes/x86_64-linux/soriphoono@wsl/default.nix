{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../soriphoono
  ];

  sops.age.keyFile = lib.mkForce "~/.config/sops/age/keys.txt";

  programs.bash.initExtra = ''
    ${pkgs.fish}/bin/fish
  '';

  core.ssh.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEgxxFcqHVwYhY0TjbsqByOYpmWXqzlVyGzpKjqS8mO7";
}

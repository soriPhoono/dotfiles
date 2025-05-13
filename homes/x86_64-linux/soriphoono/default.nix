{
  imports = [
    ./fastfetch.nix
    ./git.nix
    ./starship.nix
    ./ssh.nix
  ];

  core = {
    secrets = {
      defaultSopsFile = ./secrets.yaml;
    };
  };

  programs.fish.shellInitLast = ''
    fastfetch
  '';
}

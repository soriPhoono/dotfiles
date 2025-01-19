let
  username = "soriphoono";

  homeDirectory = "/home/${username}";
in {
  core = {
    fish.enable = true;
    starship.enable = true;

    git = {
      inherit username;

      enable = true;
      email = "soriphoono@gmail.com";
    };

    editors.helix.enable = true;
  };

  home = {inherit homeDirectory;};

  sops = {
    age.keyFile = "${homeDirectory}/.age-key.txt";

    defaultSopsFile = ../../../secrets/soriphoono/user.yaml;

    secrets.ssh_private = {};
  };
}

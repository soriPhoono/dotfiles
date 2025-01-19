{config, ...}: let
  username = "soriphoono";
in {
  core = {
    inherit username;

    secrets.enable = true;

    fish.enable = true;
    starship.enable = true;

    editors.helix.enable = true;

    git = {
      inherit username;

      enable = true;
      email = "soriphoono@gmail.com";
    };
  };

  sops = {
    secrets.ssh_private = {
      path = "%r/test.txt";
    };
  };
}

{
  core = {
    secrets.defaultSopsFile = ./secrets.yaml;

    shells = {
      shellAliases = {
        v = "nvim";
      };
    };

    git = {
      userName = "soriphoono";
      userEmail = "soriphoono@gmail.com";
    };
  };

  sops.secrets.age_key.path = "$HOME/.config/sops/age/keys.txt";
}

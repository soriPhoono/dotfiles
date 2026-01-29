let
  users = {
    soriphoono = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEgxxFcqHVwYhY0TjbsqByOYpmWXqzlVyGzpKjqS8mO7";
  };

  teams = {
    cloud = {
      users = [
        "soriphoono"
      ];
      secrets = [];
    };
  };

  agenix-shell-secrets = builtins.concatLists (map (team:
    map (secret: {
      name = builtins.toUpper secret;
      value.file = ./secrets/${secret}.age;
    })
    team.secrets) (builtins.filter (team: builtins.elem (builtins.getEnv "USER") team.users) (builtins.attrValues teams)));
in
  {
    inherit agenix-shell-secrets;
  }
  // (builtins.listToAttrs (builtins.concatLists (map (team:
    map (secret: {
      name = "secrets/${secret}.age";
      value.publicKeys = map (user: users.${user}) team.users;
    })
    team.secrets) (builtins.attrValues teams))))

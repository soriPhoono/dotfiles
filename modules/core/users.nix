{ username
, ...
}: {
  users.users.${username} = {
    name = "${username}";

    isNormalUser = true;
  };
}

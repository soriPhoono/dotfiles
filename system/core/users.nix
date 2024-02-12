{ pkgs, ... }: {
  users.users.soriphoono = {
    password = "password"; # Set the user’s password to ‘password’.

    isNormalUser = true; # Set the user as a normal user.

    shell = pkgs.zsh; # Set the user’s shell to Zsh.

    extraGroups = [
      "wheel" # Add the user to the "wheel" group.
    ];
  };
}

{ pkgs, ... }: {
  imports = [
    <home-manager/nixos>
  ];

  users.users.soriphoono = {
    name = "soriphoono";
    description = "Sori Phoono";
    password = "password";

    isNormalUser = true;

    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  home-manager.users.soriphoono = { pkgs, ... }: {
    home.packages = [

    ];

    programs = {
      git = {
        enable = true;

        config = {
          user = {
            name = "soriphoono";
            email = "soriphoono@gmail.com";
          };
          init = {
            defaultBranch = "main";
          };
          url = {
            "https://github.com/" = {
              insteadOf = [
                "gh:"
                "github:"
              ];
            };
          };
        };
      };
    };

    home.stateVersion = "23.11";
  };
}

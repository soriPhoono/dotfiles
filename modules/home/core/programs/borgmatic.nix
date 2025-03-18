{config, ...}: {
  programs.borgmatic = {
    enable = true;
    backups = {
      personal = {
        location = {
          sourceDirectories = [
            "${config.home.homeDirectory}/Documents"
            "${config.home.homeDirectory}/Music"
            "${config.home.homeDirectory}/Pictures"
            "${config.home.homeDirectory}/Videos"
          ];
          repositories = [
            {
              path = "/persist/home/${config.home.username}/backup.borg";
              label = "local";
            }
          ];
        };

        consistency.checks = [
          {
            name = "repository";
            frequency = "2 weeks";
          }
          {
            name = "archives";
            frequency = "4 weeks";
          }
          {
            name = "data";
            frequency = "6 weeks";
          }
          {
            name = "extract";
            frequency = "6 weeks";
          }
        ];
      };
    };
  };

  core.impermanence.files = [
    "backup.borg"
  ];
}

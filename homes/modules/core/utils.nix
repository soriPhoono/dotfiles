{
  programs = {
    fastfetch = {
      enable = true;

      settings = {
        logo = {
          source = ../../../assets/ascii/fastfetch.txt;
          color = {
            "1" = "cyan";
          };
          
          padding = {
            right = 1;
          };
        };

        display = {
          size = {
            binaryPrefix = "si";
          };

          color = "cyan";
          separator = "  ";

          temp = {
            unit = "F";
          };
        };

        modules = [
          {
            type = "datetime";
            key = "Date";
            format = "{1}-{3}-{11}";
          }
          {
            type = "datetime";
            key = "Time";
            format = "{14}:{17}:{20}";
          }
          "break"
          "player"
          "media"
        ];
      };
    };

    eza = {
      enable = true;
      enableFishIntegration = true;

      extraOptions = [
        "--group-directories-first"
      ];

      git = true;
      icons = true;
    };
  };
}

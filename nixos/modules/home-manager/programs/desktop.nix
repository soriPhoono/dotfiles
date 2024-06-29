{ pkgs, ... }: {
  home.packages = with pkgs; [
    imagemagick

    unzip
    unrar
    p7zip
  ];

  programs = {
    alacritty = {
      enable = true;

      settings = {
        window = {
          opacity = 0.8;


          blur = true;

          decorations = "None";
          startup_mode = "Maximized";
        };

        cursor.style = "Beam";
      };
    };
  };
}

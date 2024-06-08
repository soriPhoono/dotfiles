{ ... }: {
  xdg = {
    enable = true;

    userDirs = {
      enable = true;

      createDirectories = true;
    };

    desktopEntries = {
      google-docs = {
        name = "Google Docs";
        genericName = "Document editor";

        exec = "firefox https://docs.google.com/";
        terminal = false;
        categories = [
          "Application"
          "Office"
        ];
        mimeType = [
          "text/pdf"
          "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
        ];
      };
    };
  }

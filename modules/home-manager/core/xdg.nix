{ ... }: {
  imports = [
    ./xdg-user-dirs.nix
  ];

  xdg = {
    enable = true;

    userDirs = {
      enable = true;

      createDirectories = true;
    };

    desktopEntries = {
      google-calendar = {
        name = "Google Calendar";
        genericName = "Calendar";

        exec = "firefox https://calendar.google.com/";
        terminal = false;
        categories = [
          "Application"
          "Office"
        ];
        mimeType = [
          "text/calendar"
        ];
      };
      google-drive = {
        name = "Google Drive";
        genericName = "Cloud storage";

        exec = "firefox https://drive.google.com/";
        terminal = false;
        categories = [
          "Application"
          "Office"
        ];
        mimeType = [
          "text/pdf"
          "application/vnd.google-apps.file"
        ];
      };
      gmail = {
        name = "Gmail";
        genericName = "Email client";

        exec = "firefox https://mail.google.com/";
        terminal = false;
        categories = [
          "Application"
          "Network"
          "Email"
        ];
        mimeType = [
          "message/rfc822"
        ];
      };
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
      google-slides = {
        name = "Google Slides";
        genericName = "Presentation editor";

        exec = "firefox https://slides.google.com/";
        terminal = false;
        categories = [
          "Application"
          "Office"
        ];
        mimeType = [
          "text/pdf"
          "application/vnd.openxmlformats-officedocument.presentationml.presentation"
        ];
      };
      google-sheets = {
        name = "Google Sheets";
        genericName = "Spreadsheet editor";

        exec = "firefox https://sheets.google.com/";
        terminal = false;
        categories = [
          "Application"
          "Office"
        ];
        mimeType = [
          "text/pdf"
          "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        ];
      };
      google-tasks = {
        name = "Google Tasks";
        genericName = "Task manager";

        exec = "firefox https://tasks.google.com/";
        terminal = false;
        categories = [
          "Application"
          "Office"
        ];
      };
      google-keep = {
        name = "Google Keep";
        genericName = "Note-taking app";

        exec = "firefox https://keep.google.com/";
        terminal = false;
        categories = [
          "Application"
          "Office"
        ];
      };
    };
  };
}

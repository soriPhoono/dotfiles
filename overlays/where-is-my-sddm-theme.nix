final: prev: {
  where-is-my-sddm-theme = prev.where-is-my-sddm-theme.override {
    themeConfig.General = {
      hideCursor = false;
      passwordInputWidth = 0.4;
      passwordInputRadius = 0.5;
      passwordFontSize = 36;
      passwordInputCursorVisible = false;
      passwordCharacter = "•";
      backgroundFill = "#1e1e2e";
      blurRadius = 10;
      basicTextColor = "#cdd6f4";
      passwordCursorColor = "#cdd6f4";
      passwordInputBackground = "#313244";
      passwordTextColor = "#cdd6f4";
      showUsersByDefault = true;
      showSessionsByDefault = true;
      usersFontSize = 24;
    };
  };
}

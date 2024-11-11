final: prev: {
  where-is-my-sddm-theme = prev.where-is-my-sddm-theme.override {
    themeConfig.General = {
      hideCursor = true;
      passwordInputWidth = 0.5;
      passwordInputRadius = 0.5;
      passwordFontSize = 48;
      passwordInputCursorVisible = false;
      backgroundFill = "#1e1e2e";
      basicTextColor = "#cdd6f4";
      passwordCursorColor = "#cdd6f4";
      passwordInputBackground = "#1e1e2e";
      passwordTextColor = "#cdd6f4";
    };
  };
}

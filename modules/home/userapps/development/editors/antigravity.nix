{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.development.editors.antigravity;
in
  with lib; {
    options.userapps.development.editors.antigravity = {
      enable = mkEnableOption "Enable google antigravity AI accelerated coding platform";
    };

    config = mkIf cfg.enable {
      home.packages = [
        pkgs.antigravity
      ];

      systemd.user = {
        services.antigravity-theme-sync = {
          Unit = {
            Description = "Synchronize Antigravity theme with caelestia-shell";
            After = ["graphical-session-pre.target"];
            PartOf = ["graphical-session.target"];
          };

          Service = let
            caelestia-sync =
              pkgs.writers.writePython3Bin
              "antigravity-caelestia-sync" {}
              # Python
              ''
                #!/usr/bin/env python3
                import json
                import os
                import sys
                from pathlib import Path

                def sync_theme():
                    # Paths
                    home = Path.home()
                    caelestia_state = home / ".local/state/caelestia/scheme.json"
                    antigravity_settings = home / ".config/Antigravity/User/settings.json"

                    if not caelestia_state.exists():
                        print(f"Caelestia state file not found: {caelestia_state}")
                        return

                    try:
                        with open(caelestia_state, 'r') as f:
                            scheme = json.load(f)
                    except Exception as e:
                        print(f"Error reading Caelestia state: {e}")
                        return

                    colors = scheme.get("colours", {})
                    if not colors:
                        # Try finding in the outer root if it's there
                        colors = scheme.get("colors", {})

                    if not colors:
                        print("No colors found in scheme file")
                        return

                    # Helper to add # to hex if missing
                    def fix_hex(c):
                        if not c: return c
                        if not c.startswith("#"):
                            return f"#{c}"
                        return c

                    # Mapping Caelestia -> Antigravity (VSCode)
                    # Caelestia keys often: background, onBackground, primary, surfaceContainer, etc.
                    bg = fix_hex(colors.get("background", colors.get("base")))
                    fg = fix_hex(colors.get("onBackground", colors.get("text")))
                    primary = fix_hex(colors.get("primary"))
                    surface = fix_hex(colors.get("surfaceContainer", colors.get("surface")))
                    secondary = fix_hex(colors.get("secondary"))
                    accent = primary

                    color_customizations = {
                        "editor.background": bg,
                        "editor.foreground": fg,
                        "sideBar.background": bg,
                        "sideBar.foreground": fg,
                        "activityBar.background": bg,
                        "activityBar.foreground": fg,
                        "activityBar.activeBorder": primary,
                        "statusBar.background": bg,
                        "statusBar.foreground": fg,
                        "titleBar.activeBackground": bg,
                        "titleBar.activeForeground": fg,
                        "editorGroupHeader.tabsBackground": surface,
                        "tab.activeBackground": bg,
                        "tab.activeForeground": fg,
                        "tab.inactiveBackground": surface,
                        "tab.inactiveForeground": fg,
                        "tab.activeBorder": primary,
                        "statusBarItem.remoteBackground": primary,
                        "list.activeSelectionBackground": f"{primary}44", # Semi-transparent
                        "list.activeSelectionForeground": fg,
                        "list.hoverBackground": f"{primary}22",
                        "menu.background": bg,
                        "menu.foreground": fg,
                        "menu.selectionBackground": f"{primary}44",
                        "terminal.background": bg,
                        "terminal.foreground": fg,
                    }

                    # Remove None values
                    color_customizations = {k: v for k, v in color_customizations.items() if v}

                    # Load Antigravity settings
                    settings = {}
                    if antigravity_settings.exists():
                        try:
                            with open(antigravity_settings, 'r') as f:
                                settings = json.load(f)
                        except Exception as e:
                            print(f"Error reading Antigravity settings: {e}")
                            # If it's corrupted, we'll start with empty and overwrite

                    settings["workbench.colorCustomizations"] = color_customizations

                    # Ensure directory exists
                    antigravity_settings.parent.mkdir(parents=True, exist_ok=True)

                    try:
                        with open(antigravity_settings, 'w') as f:
                            json.dump(settings, f, indent=4)
                        print("Antigravity theme synchronized successfully")
                    except Exception as e:
                        print(f"Error writing Antigravity settings: {e}")

                if __name__ == "__main__":
                    sync_theme()
              '';
          in {
            Type = "oneshot";
            ExecStart = "${caelestia-sync}/bin/antigravity-caelestia-sync";
          };

          Install = {
            WantedBy = ["graphical-session.target"];
          };
        };

        paths.antigravity-theme-sync = {
          Unit = {
            Description = "Watch for caelestia theme changes";
          };

          Path = {
            PathModified = "%h/.local/state/caelestia/scheme.json";
          };

          Install = {
            WantedBy = ["graphical-session.target"];
          };
        };
      };
    };
  }

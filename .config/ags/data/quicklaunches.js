export const quickLaunchItems = [
    {
        "name": "Development workflow",
        "command": "xdg-open 'https://youtube.com/' && logseq --enable-features=UseOzonePlatform --ozone-platform=wayland & && xdg-open 'https://github.com/' && code --password-store=gnome --enable-features=UseOzonePlatform --ozone-platform=wayland &"
    }, // development tools
    {
        "name": "Terminal×2",
        "command": "foot & && foot &"
    }, // default terminal emulator window config for system work
    {
        "name": "Steam",
        "command": "steam-native &"
    } // Gaming setup for steam
]
# Dot files
My personal collection of configuration files for a complete Linux desktop environment based on the QTile window manager

## Usage
Simply follow the installation instructions below to install the dot files on your system. Then reboot as this repository does install numerous driver packages that may or may not require a reboot to function properly.

## Installation
This repository can be cloned on its own and setup by running the bootstrap script located at .config/yadm/bootstrap

However it is more easily ran by using [yadm](https://github.com/TheLocehiliosan/yadm), it can be installed via the following command on a newly installed arch Linux system:
```
sudo pacman -S yadm
```
Once installed, the repository can be cloned and setup by running the following command:
```
yadm clone https://github.com/soriphoono/dotfiles.git
```
You will be prompted to run the bootstrap script, which will install all the necessary packages and setup the system. The default branch or, in my current implementation strategy, feature set that gets installed upon cloning is the installer branch which will route you to the feature set you are looking for

If the prompt does not occur you can manually trigger it via the following command:
```
yadm bootstrap
```
If the bootstrap script fails to run, you can manually give it executable permissions and run it:
```
chmod +x ~/.config/yadm/bootstrap
```
Followed by running the script with the bootstrap command or manually triggering the script

## Features
The script installs the following features for this branch
- Automatic configuration of pacman package installer
- Optional configuration of chaotic-AUR and multi-lib repository
- Optimization of mirrors with reflector
- Complete CLI environment with new tools used under familiar names
	- Ex: ls replaced by eza (community maintained exa)
- Uses zsh shell with the starship prompt auto configured
- Automatically integrates git with revamped CLI environment and configures it to use the tools it provides
- Automatic installation and configuration of Network Manager with openvpn and openconnect support along with configuration of ufw for firewall support
- Optional configuration of dnscrypt and tor+i2p support for the privacy conscious among us
	- All DNS requests are forwarded through tor, and only sent to dnscrypt supporting servers that respect privacy and use encryption
	- Tor is ran in a chroot for security purposes
- Automatic configuration of system video drivers, even on laptops or single APU systems out of the box, with support for dual GPU systems planned (WIP)
	- AMD supports installation of libva + amf, opencl, fan control in dedicated mode along with side-loaded amdgpu pro drivers for amf support
	- Nvidia supports installation of nvdec and nvenc support, cuda configuration, and opencl support
	- Intel igpu support with up to date support for hardware video acceleration and GPGPU programming on intel-compute-runtime
	- Supports auto installation of guest additions in virtualbox
- Themed after the catppuccin mocha theme with an emphasis on teal, uses source code pro nerd fonts, and papirus icon theme
- Uses sugar candy sddm theme
- Uses both pipewire and gstreamer as video pipelines
- Optional bluetooth installation and configuration
- Installation of either firefox, google chrome, or both
- Support for installation of the Chevron start page in hosted mode
- Optional installation of discord, betterdiscordctl with setup instructions, themed spotify with adblocking on spicetify, spotify download script built off of yt-dlp, along with signal and telegram installation for private communications
- Optional installation of complete custom developer environment (WIP)
- Optional installation of steam, heroic launcher,  minecraft instance manager prsimlauncher, , proton/wine troubleshooters, dosbox installation, gamemode, mangohud, and gamescope setup for window manager integration.
- Optional installation of streaming and recording tools like open broadcaster software with platform dependent, auto detected amf installation and game capture integration
- Optional installation of media creation/editing tools like image editors, audio editors, 3d printing (WIP) and modeling tools, and 2d animation tools for sprites (mostly for games or animators)
- Optional installation of libre-office with spelling and grammar checking
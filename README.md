# Dotfiles

A personal repository for dotfiles pertaining to my linux setups

## Usage

Simply follow the installation instructions below to install the dotfiles on your system. Then reboot as this repository does install numerous driver packages that may or may not require a reboot to function properly.

## Installation

This repository can be cloned on its own and setup by running the bootstrap script located at .config/yadm/bootstrap

However it is more easily ran by using [yadm](https://github.com/TheLocehiliosan/yadm), it can be installed via the following command on a newly installed arch linux system:

```
sudo pacman -S yadm
```

Once installed, the repository can be cloned and setup by running the following command:

```
yadm clone https://github.com/soriphoono/dotfiles.git
```

You will be prompted to run the bootstrap script, which will install all the necessary packages and setup the system.

If the prompt does not occur you can manually trigger it via the following command:

```
yadm bootstrap
```

If the bootstrap script fails to run, you can manually give it executable permissions and run it:

```
chmod +x ~/.config/yadm/bootstrap
```

Followed by running the script

## Features

This branch contains little to no actual content pertaining to the final installation state,
this is because this branch simply houses the boilerplate for the final installation.
If you wish to gain a more comprehensive view of what this script does, please check the readme
entries in the other branches who's names do not begin with the word boilerplate.

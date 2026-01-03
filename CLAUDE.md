# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a NixOS flake-based dotfiles and system configuration repository using **Snowfall lib** for modular organization. It manages multiple hosts (personal laptops, servers, LXC containers) and users with declarative, reproducible configurations.

## Essential Commands

### System Operations
```bash
# Rebuild NixOS system configuration
sudo nixos-rebuild switch --flake .#<hostname>

# Test system changes without activating
nixos-rebuild dry-activate --flake .#<hostname>

# Apply Home Manager configuration
home-manager switch --flake .#<user>@<host>

# Update all flake inputs
nix flake update

# Update specific input
nix flake lock --update-input <input-name>

# Check flake for errors
nix flake check
```

### Development
```bash
# Enter development shell (provides: age, sops, disko, nixos-facter)
nix develop

# Format Nix files
nix fmt

# Build specific output
nix build .#<output>
```

## Architecture Overview

### Snowfall Lib Convention

This flake uses Snowfall lib for automatic module discovery. Directory structure determines behavior:

- **`modules/nixos/`** - Auto-imported as NixOS modules
- **`modules/home/`** - Auto-imported as Home Manager modules
- **`systems/<arch>/<hostname>/`** - NixOS system configurations
- **`homes/<arch>/<user>@<host>/`** - Home Manager user configurations
- **`overlays/`** - Automatically applied Nixpkgs overlays
- **`shells/`** - Development shells

### Module Structure Pattern

All modules follow this pattern:

```nix
{lib, pkgs, config, ...}:
let
  cfg = config.<namespace>.<module-path>;
in
  with lib; {
    options.<namespace>.<module-path> = {
      enable = mkEnableOption "description";
      # Additional options...
    };

    config = mkIf cfg.enable {
      # Configuration implementation
    };
  }
```

Custom options use the `soriphoono` namespace (defined in flake.nix).

### Module Organization

**`modules/nixos/`** - System-level NixOS modules:
- **`core/`** - Essential system config (boot, users, networking, secrets)
  - `users.nix` - Declarative user management with SOPS integration
  - `boot.nix` - Bootloader (systemd-boot/lanzaboote for secure boot)
  - `secrets.nix` - SOPS secrets management
- **`desktop/`** - Desktop environments and features
  - `environments/` - KDE, Cosmic, Hyprland configurations
  - `features/` - Gaming, virtualisation, printing
  - `services/` - Pipewire, Flatpak, SDDM, etc.
- **`hosting/`** - Server features (Docker, Podman)

**`modules/home/`** - User-level Home Manager modules:
- **`core/`** - Essential user config (git, shells, ssh, secrets)
- **`desktop/environments/hyprland/`** - Hyprland window manager user config
- **`userapps/`** - Application configurations (browsers, development tools)

### User Management Pattern

Users are defined once in system configurations using `core.users` option, which automatically:
1. Creates NixOS user accounts
2. Configures Home Manager for each user
3. Sets up SSH keys from `publicKey` option
4. Integrates with SOPS for password hashes

Example from system config:
```nix
core.users = {
  soriphoono = {
    hashedPassword = config.sops.placeholder.soriphoono;
    admin = true;
    shell = pkgs.fish;
    publicKey = "ssh-ed25519 AAAA...";
  };
};
```

### Secrets Management

Uses SOPS for encrypted secrets:
- Each system/home has a `secrets.yaml` file (encrypted)
- Keys defined at top of file, referenced in configuration
- Never commit unencrypted secrets
- System secrets: `/run/secrets/<secret-name>`
- Home Manager secrets: `~/.config/sops-nix/secrets/<secret-name>`

### Hardware Configuration

GPU support is modular via `core.hardware.gpu`:
- `amd.enable` - AMD GPU support
- `intel.enable` - Intel integrated graphics
- `nvidia.enable` - Nvidia proprietary drivers

Other hardware options in `core.hardware`: bluetooth, xbox controllers, wacom tablets, ADB.

### Desktop Environments

Desktop environments are composable:
- Enable via `desktop.environments.<env>.enable`
- Each environment has its own display manager preference
- Hyprland has extensive per-user customization in `modules/home/desktop/environments/hyprland/`

### System Targets

This flake supports:
- **x86_64-linux** - Standard Linux systems (workstations, laptops, servers)
- **x86_64-iso** - NixOS installer images
- **x86_64-proxmox-lxc** - Proxmox LXC container templates

## Key Flake Inputs

- **home-manager** - Per-user configuration management
- **sops-nix** - Secrets management (both NixOS and Home Manager)
- **disko** - Declarative disk partitioning
- **lanzaboote** - Secure boot support (v0.4.2 pinned)
- **nvf** - Neovim configuration framework
- **awww** - Wayland wallpaper daemon
- **nix-index-database** - Command-not-found lookup

All inputs follow `nixpkgs` (unstable) for consistency.

## Configuration Workflow

1. **Adding a new host:**
   - Create `systems/<arch>/<hostname>/default.nix`
   - Define system options (boot, hardware, desktop, etc.)
   - Optionally create `<hostname>-disko.nix` for disk layout
   - Create corresponding `homes/<arch>/<user>@<host>/default.nix`

2. **Adding a new module:**
   - Create module in appropriate location under `modules/`
   - Follow the standard module pattern with `options` and `config`
   - Snowfall automatically discovers and imports it
   - Reference in system/home configs via the option path

3. **Managing secrets:**
   - Edit encrypted secrets: `sops secrets.yaml`
   - Add new secret keys to the YAML file
   - Reference in config: `config.sops.placeholder.<secret-name>` (NixOS) or `config.sops.secrets.<secret-name>.path` (Home Manager)

4. **Modifying existing configuration:**
   - Find relevant module in `modules/` directory
   - Edit the module implementation
   - Test with `nixos-rebuild dry-activate` or `home-manager switch`

## Project Conventions

- Host and user directories use `<user>@<host>` naming convention
- `default.nix` is the entry point for each directory
- All configuration is declarative - no imperative modifications
- Use `mkIf cfg.enable` for conditional configuration application
- Prefer adding features as modules rather than inline in system configs
- Use overlays for custom packages instead of patching nixpkgs directly
- Set `mutableUsers = false` for full declarative user management

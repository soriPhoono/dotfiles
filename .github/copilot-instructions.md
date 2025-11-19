# Copilot Instructions for AI Agents

## Project Overview
This repository is a Nix-based dotfiles and system configuration project, structured for declarative, reproducible Linux setups. It uses Nix flakes and Home Manager to manage user environments, system modules, and overlays for multiple hosts and users.

## Key Structure
- `flake.nix`: Entry point for the project, defines inputs, outputs, and flake modules.
- `homes/`: Home Manager configurations per host and user. Example: `homes/x86_64-linux/soriphoono@workstation/`.
- `modules/`: Reusable NixOS and Home Manager modules, organized by domain (core, userapps, desktop, etc.).
- `systems/`: NixOS system configurations per host. Example: `systems/x86_64-linux/workstation/`.
- `overlays/`: Nixpkgs overlays for custom packages or modifications.
- `templates/`: Project templates for various languages (python, rust, dotnet).

## Essential Workflows
- **Rebuild system:**
  - `sudo nixos-rebuild switch --flake .#<hostname>`
- **Update flake inputs:**
  - `nix flake update`
- **Apply user config:**
  - `home-manager switch --flake .#<user>@<host>`
- **Test changes (dry-run):**
  - `nixos-rebuild dry-activate --flake .#<hostname>`

## Project Conventions
- Host and user directories are named as `<user>@<host>` for clarity and reproducibility.
- Secrets are managed via `secrets.yaml` files, referenced in Nix modules but not committed.
- Modularize configuration: prefer adding new features as modules under `modules/` and referencing them in system/home configs.
- Use overlays for custom package logic instead of patching upstream Nixpkgs directly.
- Use `default.nix` as the entry point in each directory.

## Integration Points
- Home Manager and NixOS modules are cross-referenced via flake outputs.
- External secrets and sensitive data are handled via `secrets.yaml` and not stored in git.
- Templates provide quick project bootstrapping for supported languages.

## Examples
- To add a new user application, create a module in `modules/home/userapps/` and import it in the relevant `homes/` config.
- To add a new host, copy an existing host directory in `systems/x86_64-linux/` and adjust as needed.

## References
- See `flake.nix` for the main project entry and module wiring.
- See `modules/` for reusable configuration patterns.
- See `homes/` and `systems/` for per-user and per-host customization.

---
_If you are unsure about a workflow or pattern, check for similar examples in the relevant directory or ask for clarification._

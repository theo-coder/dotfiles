![dotfiles-logo](https://github.com/theo-coder/dotfiles/assets/57922624/79b4f139-c937-46fd-87df-4192206d173f)
<p align="center">
    <a href="https://github.com/theo-coder/dotfiles/issues"><img align="center" src="https://img.shields.io/github/issues/theo-coder/dotfiles"/></a>
    <a href="https://github.com/theo-coder/dotfiles/commits/main"><img align="center" src="https://img.shields.io/github/last-commit/theo-coder/dotfiles"/></a>
    <a href="https://github.com/theo-coder"><img align="center" src="https://img.shields.io/badge/author-theo--coder-blue"/></a>
</p>

---

## Architecture (Dendritic Pattern)

This NixOS & Home Manager configuration uses the **Dendritic Pattern** (`flake-parts` + `import-tree`):
- Every `.nix` file under `modules/` is a `flake-parts` module representing a single feature/aspect across both NixOS (`flake.modules.nixos.<aspect>`) and Home Manager (`flake.modules.homeManager.<aspect>`).
- Raw application configuration files (Niri KDL, Neovim Lua, Fish functions, Kitty, Rofi, scripts) live in `configs/`.
- Desktop stack: **Niri** + **Dux Shell (Quickshell)** + **Dux Greeter**, alongside **Hyprland** selectable at login.

```text
.
├── flake.nix
├── secrets.example.nix   # Template for local secrets & personal info
├── assets/
├── configs/              # Out-of-store dotfiles (niri, nvim, fish, kitty, bin, lib)
└── modules/              # Auto-imported flake-parts aspect modules
    ├── flake/            # Flake metadata & local secrets option
    ├── hosts/alpha/      # Host composition & hardware config
    ├── users/            # User account & base Home Manager setup
    ├── system/           # Boot, Nix, Locale, Network & hybrid /etc/hosts, Audio, Bluetooth, Power
    ├── desktop/          # Niri, Dux Shell, Dux Greeter, Hyprland, Stylix, Common desktop
    └── programs/         # Shell, Terminal, CLI, Git, Nvim, Coding, Browser, Games, AI
```

## Setup & Usage

1. Copy `secrets.example.nix` to `secrets.nix` (ignored by git) and fill in your personal details:
   ```bash
   cp secrets.example.nix secrets.nix
   ```

2. Rebuild the system:
   ```bash
   sudo nixos-rebuild switch --flake /home/theo/nixos#alpha --impure
   ```

### Hybrid `/etc/hosts`

`/etc/hosts` is generated with permissions `0644` (writable, not a read-only `/nix/store` symlink):
- Default entries come from `secrets.nix` (`hosts` attribute).
- You can edit `/etc/hosts` directly on the fly (e.g., `sudo vim /etc/hosts` or `hostctl`) without rebuilding.
- Any custom entries placed in `/etc/hosts.local` are automatically appended to `/etc/hosts` on every `nixos-rebuild`.

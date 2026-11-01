![dotfiles-logo](https://github.com/theo-coder/dotfiles/assets/57922624/79b4f139-c937-46fd-87df-4192206d173f)
<p align="center">
    <a href="https://github.com/theo-coder/dotfiles/issues"><img align="center" src="https://img.shields.io/github/issues/theo-coder/dotfiles"/></a>
    <a href="https://github.com/theo-coder/dotfiles/commits/main"><img align="center" src="https://img.shields.io/github/last-commit/theo-coder/dotfiles"/></a>
    <a href="https://github.com/theo-coder"><img align="center" src="https://img.shields.io/badge/author-theo--coder-blue"/></a>
</p>

---

## Architecture (Dendritic Pattern + GNU Stow)

This NixOS configuration uses the **Dendritic Pattern** (`flake-parts` + `import-tree`) coupled with **GNU Stow** for user dotfiles:
- Every `.nix` file under `modules/` is a `flake-parts` module representing a single feature/aspect (`flake.modules.nixos.<aspect>`).
- User dotfiles (`niri`, `nvim`, `fish`, `starship`, `kitty`, `git`, scripts, custom `.desktop` entries) live in `configs/` (mirroring `$HOME`) and are symlinked via **GNU Stow** (`stow --no-folding`).
- Desktop stack: **Niri** + **Dux Shell (Quickshell)** + **Dux Greeter**.

```text
.
├── flake.nix
├── secrets.example.nix   # Template for local secrets & personal info
├── assets/
├── configs/              # GNU Stow package targeting ~
│   ├── .config/          # fish, git, gtk, kitty, niri, nvim, starship
│   └── .local/           # bin, share/applications
└── modules/              # Auto-imported flake-parts aspect modules
    ├── flake/            # Flake metadata & local secrets option
    ├── hosts/alpha/      # Host composition & hardware config
    ├── users/            # User account & automatic GNU Stow activation
    ├── system/           # Boot, Nix, Locale, Network & hybrid /etc/hosts, Audio, Bluetooth, Power
    ├── desktop/          # Niri, Dux Shell, Dux Greeter, Stylix, Common desktop
    └── programs/         # Shell, Terminal, CLI, Git, Nvim, Coding, Browser, Games, AI
```

## Setup & Usage

1. Copy `secrets.example.nix` to `secrets.nix` (ignored by git) and fill in your personal details:
   ```bash
   cp secrets.example.nix secrets.nix
   ```

2. Rebuild the system (also runs `stow` and generates `~/.config/git/config.local` automatically):
   ```bash
   sudo nixos-rebuild switch --flake /home/theo/nixos#alpha --impure
   ```

3. To re-stow dotfiles manually without rebuilding NixOS:
   ```bash
   stow --no-folding -R -d /home/theo/nixos -t /home/theo configs
   ```

### Hybrid `/etc/hosts`

`/etc/hosts` is generated with permissions `0644` (writable, not a read-only `/nix/store` symlink):
- Default entries come from `secrets.nix` (`hosts` attribute).
- You can edit `/etc/hosts` directly on the fly (e.g., `sudo vim /etc/hosts` or `hostctl`) without rebuilding.
- Any custom entries placed in `/etc/hosts.local` are automatically appended to `/etc/hosts` on every `nixos-rebuild`.

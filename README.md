## Requirements

### Operating System

Only works on Arch (btw)

## Usage

### Available Tags

- system
- neovim
- qtile

### Install

To install all the dotfiles run the following:
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/theo-coder/dotfiles/main/bin/dotfiles)"
```

If you want to run a specific role, here is the magic:
```bash
curl -fsSL https://raw.githubusercontent.com/theo-coder/dotfiles/main/bin/dotfiles | bash -s -- --tags comma,seperated,tags
```

![dotfiles-logo](https://github.com/theo-coder/dotfiles/assets/57922624/79b4f139-c937-46fd-87df-4192206d173f)
<p align="center">
    <a href="https://github.com/theo-coder/dotfiles/actions/workflows/ansible-lint.yml"><img align="center" src="https://github.com/theo-coder/dotfiles/actions/workflows/ansible-lint.yml/badge.svg"/></a>
    <a href="https://github.com/theo-coder/dotfiles/issues"><img align="center" src="https://img.shields.io/github/issues/theo-coder/dotfiles"/></a>
    <a href="https://github.com/theo-coder/dotfiles/commits/main"><img align="center" src="https://img.shields.io/github/last-commit/theo-coder/dotfiles"/></a>
    <a href="https://github.com/theo-coder"><img align="center" src="https://img.shields.io/badge/author-theo--coder-blue"/></a>
</p>

---

## Requirements

### Operating System

Only works on Arch (btw)

## Usage

### Available Tags

- system
- neovim
- qtile
- alacritty

### Install

To install all the dotfiles run the following:
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/theo-coder/dotfiles/main/bin/dotfiles)"
```

If you want to run a specific role, here is the magic:
```bash
curl -fsSL https://raw.githubusercontent.com/theo-coder/dotfiles/main/bin/dotfiles | bash -s -- --tags comma,seperated,tags
```

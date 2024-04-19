# Readme vic

This branch `main` contains the configs for Astronvim v4. Old configs are at
branch `v3-archive`.
The `main` branch has as parent the branch `template-main`, which corresponds
to https://github.com/AstroNvim/template.

# Installing

Run `:checkhealth` for debugging.

Deps:

```console
apt install wl-clipboard nerd fonts node
apt install luarocks gdu # optional deps
```

# TODO

- Linter for Makefiles
- see TODOs in config

---

the rest of this document content is the README.md from the template.

---

# AstroNvim Template

**NOTE:** This is for AstroNvim v4+

A template for getting started with [AstroNvim](https://github.com/AstroNvim/AstroNvim)

## 🛠️ Installation

#### Make a backup of your current nvim and shared folder

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

#### Create a new user repository from this template

Press the "Use this template" button above to create a new repository to store your user configuration.

You can also just clone this repository directly if you do not want to track your user configuration in GitHub.

#### Clone the repository

```shell
git clone https://github.com/<your_user>/<your_repository> ~/.config/nvim
```

#### Start Neovim

```shell
nvim
```

# dotfiles
![macOS](screen.png)
## setup

* window manager: aerospace+sketchybar
* terminal: ghostty
* editor: neovim + lazy
* shell: bash
* prompt: starship
* terminal multiplexer: herdr
* git: lazygit
* browser: Dia
* theme: gruvbox dark
* ai: pi

## Stow quick start

This repo uses GNU Stow with the `home/` directory as a mirror of your real `$HOME`.

### 1) Install GNU Stow

```bash
brew install stow
```

### 2) Apply dotfiles symlinks

```bash
stow -R -v -d "$HOME/repos/dotfiles" -t "$HOME" home
```

### 3) Re-apply after changes

Run the same command after any edits in this repo:

```bash
stow -R -v -d "$HOME/repos/dotfiles" -t "$HOME" home
```

### 4) Remove symlinks created by stow

```bash
stow -D -v -d "$HOME/repos/dotfiles" -t "$HOME" home
```

### 5) Important rule

Edit files in this repo (`home/...`), not directly in `~/.config` or `~/.*`.

If you edit symlink targets directly outside repo, your changes can drift from version control.

## Private/local files (not in git)

Keep sensitive or work-specific data outside this repo:

- `~/.bashrc.local` (tokens, internal aliases, AWS profiles)
- `~/.gitconfig.local` (name/email)
- `~/.config/opencode/agents/*.private.md` (private policies)
- `~/.pi/agent/AGENTS.md` (local agent guidance)

Load local bash settings from `~/.bashrc` with:

```bash
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
```

## Before publishing

Run this check before commit/push:

```bash
git add -A
git diff --cached | rg -i "token|secret|password|awsapps|atlassian.net|corp|internal"
```

If output is not empty, remove or move those lines/files before publishing.

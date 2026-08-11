# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/bashrc.pre.bash" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/bashrc.pre.bash"

# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Use vi mode for command editing
set -o vi

# clear screen with Ctrl-l
bind -x '"\C-l":clear'

eval "$(fzf --bash)"

# ignore case in autocomplete
bind 'set completion-ignore-case on'

# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

# Editor
export EDITOR="nvim"
export OPENCODE_DISABLE_CLAUDE_CODE=1

# Directories
export REPOS="$HOME/repos"
export GHREPOS="$REPOS/github.com/${GITUSER:-}"
export XDG_CONFIG_HOME="$HOME/.config"
export DOTFILES="$REPOS/dotfiles"
export SCRIPTS="$DOTFILES/scripts"
export KUBE_EDITOR="nvim"

# PATH
export PATH="$DOTFILES/scripts:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Go
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOBIN"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac

export PATH="$PATH:$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"

# Pi Cursor SDK bridge
export PI_CURSOR_EXPOSE_BUILTIN_TOOLS=1
export PI_CURSOR_PI_TOOL_BRIDGE=1
export PI_CURSOR_SETTING_SOURCES=project,plugins,team
export PI_CURSOR_MCP_CONNECT_TIMEOUT_SECONDS=5
export PI_CURSOR_MCP_TOOL_TIMEOUT_SECONDS=120

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.histfile
export HISTSIZE=1000000
export HISTFILESIZE=1000000
export HISTCONTROL=ignorespace:erasedups
export HISTIGNORE="set*:****REMOVED****"
shopt -s histappend
PROMPT_COMMAND='history -a'

# ~~~~~~~~~~~~~~~~Shell Options ~~~~~~~~~~~~~~~~~~

shopt -s cdspell      # Correct minor spelling errors in cd
shopt -s checkwinsize # Check the window size after each command
shopt -s extglob      # Extended globbing

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

# Quick navigation aliases
alias v=nvim
alias ..="cd .."
alias ...='cd ../..'
alias '??'="gpt"
alias '?'="gpt-short"
alias scripts='cd $SCRIPTS'
alias dot='cd $REPOS/dotfiles'
alias repos='cd $REPOS'
alias c="clear"
alias chmox='chmod +x'

# ls with color and formatting
alias ls='ls --color=auto'
alias l='ls -l'
alias ll='ls -lha'
alias la='ls -lathr'

# Editor aliases
alias ebr='v ~/.bashrc'
alias ec='v ~/.config/opencode'
alias etr='v ~/.terraformrc'
alias et='v ~/.tmux.conf'
alias sbr='source ~/.bashrc'
alias es='v ~/.config/starship.toml'
alias eae='v ~/.config/aerospace/aerospace.toml'
alias eg="v $DOTFILES/ghostty/config"

# Git / tools
alias t='tmux'
alias ta='tmux attach'
alias tn='tmux new'
alias gp='git pull'
alias gs='git status'
alias lg='lazygit'
alias ld='lazydocker'
alias o='opencode .'
alias tf='terraform'
alias k=kubectl
alias kk='kiro-cli'
alias kkk='kiro-cli chat --no-interactive'
alias kubectl=kubecolor
alias kgp='kubectl get pods'
alias kgpo='kubectl get pods -o wide'
alias kc='kubectx'
alias kn='kubens'
alias nn='$DOTFILES/scripts/note'
alias g='gcloud'

# AWS
a() {
  local profile
  profile=$(grep -E '^\[' ~/.aws/config | sed 's/^\[profile //;s/^\[//;s/\]//' | fzf +s --tac)
  [[ -n "$profile" ]] && export AWS_PROFILE="$profile"
}
alias sso='aws sso login --profile "${AWS_PROFILE:-default}"'

# Streaming
alias twitch='ffmpeg_loop ~/Movies/twitch.mp4'
alias timecode='ffmpeg_testsrc_live'
alias twitch60='ffmpeg_loop ~/Movies/twitch60.mp4'

brew_etc="$(brew --prefix)/etc" && [[ -r "${brew_etc}/profile.d/bash_completion.sh" ]] && . "${brew_etc}/profile.d/bash_completion.sh"
complete -o default -F __start_kubectl k

# eks
. <(eksctl completion bash)

# ~~~~~~~~~~~~~~~ Private / work config ~~~~~~~~~~~~~~~~~~~~~~~~
# Loaded from ~/.bashrc.local (not tracked in dotfiles)
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local

eval "$(starship init bash)"

# opencode
export PATH=/Users/avramukk/.opencode/bin:$PATH

# OpenCode 2 — v2 shares V1 config natively, no swap needed.
opencode2() {
  command opencode2 --standalone "$@"
}

# Safety wrapper for V1: if V2 config was left active, restore V1 first.
opencode() {
  local v1_dir="$HOME/.config/opencode"
  local v1_backup="$HOME/.config/opencode.v1"
  local v2_source="$HOME/.config/opencode2"
  if [[ -L "$v1_dir" && "$(readlink "$v1_dir")" == "$DOTFILES/opencode2" ]]; then
    mv "$v1_dir" "$v2_source"
    mv "$v1_backup" "$v1_dir"
  fi
  command opencode "$@"
}

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/bashrc.post.bash" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/bashrc.post.bash"

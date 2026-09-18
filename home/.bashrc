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
export PATH="$DOTFILES:$PATH" # dot CLI (repo root); interactive bash uses the dot() wrapper instead
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
# dot CLI — cd into repo without args, run the CLI with args
# (replaces the old `alias dot='cd $REPOS/dotfiles'`)
# NOTE: unalias first — a stale `alias dot` from a previously sourced
# .bashrc gets expanded during parsing and breaks `dot() { ... }`.
unalias dot 2>/dev/null || true
dot() {
  if [[ $# -eq 0 ]]; then
    cd "$REPOS/dotfiles" || return 1
  else
    "$DOTFILES/dot" "$@"
  fi
}
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
alias lab='cd $HOME/repos/lab/'

# AWS
a() {
  local profile
  profile=$(grep -E '^\[profile ' ~/.aws/config | sed 's/^\[profile //;s/\]//' | fzf +s --tac)
  [[ -z "$profile" ]] && return 0
  export AWS_PROFILE="$profile"
  _aws_ensure_sso
}

# Resolve SSO session name a profile references ('' if it does not use one)
_aws_sso_session() {
  local profile="$1"
  awk -v pat="[profile ${profile}]" '
    $0 ~ /^\[/ { if ($0 == pat) f=1; else f=0; next }
    f && /^sso_session[[:space:]]*=/ { print $3; exit }
  ' ~/.aws/config
}

# Resolve SSO start URL for a profile ('' if it is not SSO-based)
_aws_sso_start_url() {
  local profile="$1" session
  session=$(_aws_sso_session "$profile")
  if [[ -n "$session" ]]; then
    # new sso_session model -> look up [sso-session <name>]
    awk -v pat="[sso-session ${session}]" '
      $0 ~ /^\[/ { if ($0 == pat) f=1; else f=0; next }
      f && /^sso_start_url[[:space:]]*=/ { print $3; exit }
    ' ~/.aws/config
  else
    # legacy inline sso_start_url model
    awk -v pat="[profile ${profile}]" '
      $0 ~ /^\[/ { if ($0 == pat) f=1; else f=0; next }
      f && /^sso_start_url[[:space:]]*=/ { print $3; exit }
    ' ~/.aws/config
  fi
}

# 0 if the profile can actually resolve an identity (real usability check)
_aws_profile_works() {
  local profile="$1"
  aws sts get-caller-identity --profile "$profile" >/dev/null 2>&1
}

# Ensure the selected profile is truly usable; real API check + login if needed
_aws_ensure_sso() {
  local profile="${AWS_PROFILE:-default}" url session
  url=$(_aws_sso_start_url "$profile")
  [[ -z "$url" ]] && return 0 # static/role/default profile: no SSO needed
  session=$(_aws_sso_session "$profile")
  if _aws_profile_works "$profile"; then
    echo "✓ SSO active for '${profile}'"
    return 0
  fi
  echo "SSO not active for '${profile}' — logging in…"
  if [[ -n "$session" ]]; then
    aws sso login --sso-session "$session"
  else
    aws sso login --profile "$profile"
  fi
  if _aws_profile_works "$profile"; then
    echo "✓ SSO active for '${profile}'"
  else
    echo "✗ Cannot access '${profile}' even after login — is the account assigned in ***REMOVED*** SSO?"
  fi
}

# Drop stale alias from earlier sessions so the function definition below parses on re-source.
unalias sso 2>/dev/null
sso() {
  local profile="${AWS_PROFILE:-default}" url session
  url=$(_aws_sso_start_url "$profile")
  if [[ -z "$url" ]]; then
    echo "Profile '${profile}' is a static/role profile; no SSO login needed."
    return 0
  fi
  session=$(_aws_sso_session "$profile")
  if [[ -n "$session" ]]; then
    echo "SSO login for session: ${session} (profile: ${profile})"
    aws sso login --sso-session "$session"
  else
    echo "SSO login for profile: ${profile}"
    aws sso login --profile "$profile"
  fi
}

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

# dot CLI completions (generated by `dot completions`)
[[ -f "$DOTFILES/completions/dot.bash" ]] && source "$DOTFILES/completions/dot.bash"

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/bashrc.post.bash" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/bashrc.post.bash"

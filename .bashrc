# ~/.bashrc
# Made by Mykola Avramuk.
# Inspired by Mischa van den Burg, rwxrob, bahamas, and others.
# Thanks everyone and keep sharing your knowlege and best practices.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi

# Initialize Starship prompt
eval "$(starship init bash)"

# clear screen with Ctrl-l
bind -x '"\C-l":clear'


# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

# Editor
export EDITOR="nvim"

# Directories
export REPOS="$HOME/Repos"
export GITUSER="avramukk"
export GHREPOS="$REPOS/github.com/$GITUSER"
export XDG_CONFIG_HOME="$HOME/.config"
export DOTFILES="$REPOS/dotfiles"
export SCRIPTS="$DOTFILES/scripts"
export LAB="$REPOS/lab"
export KUBE_EDITOR="nvim"
export SECOND_BRAIN="$HOME/Documents/second-brain"

# PATH
export GOBIN="$HOME/go/bin"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$DOTFILES/scripts:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# OpenAI API Key
declare OPENAI_API_KEY
OPENAI_API_KEY="$(head -1 "$XDG_CONFIG_HOME/gpt/token")"
export OPENAI_API_KEY

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.histfile
export HISTSIZE=1000000
export SAVEHIST=1000000
export HISTCONTROL=ignorespace:ignoredups:erasedups
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# ~~~~~~~~~~~~~~~~Shell Options ~~~~~~~~~~~~~~~~~~

shopt -s cdspell # Correct minor spelling errors in cd
shopt -s checkwinsize # Check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s extglob # Extended globbing
shopt -s histappend # Append to the history file, don't overwrite it
# shopt -s cmdhist # Save multi-line commands as one command

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

# Quick navigation aliases
alias v=nvim
alias ..="cd .."
alias ...='cd ../..'
alias scripts='cd $SCRIPTS'
alias lab='cd $LAB'
alias dot='cd $REPOS/dotfiles'
alias repos='cd $REPOS'
alias c="clear"
alias cv='cd $REPOS/avramukk.github.io/'
alias sb='cd -P "$SECOND_BRAIN"'
alias fn='sb && nvim'
alias m='cd $REPOS/mischa'
alias md='cd $REPOS/mischa/dotfiles'
alias rd='cd $REPOS/rwxrob/dot'
alias chmox='chmod +x'
alias pip=pipx

# ls with color and formatting
alias ls='ls --color=auto'
alias l='ls -l'
alias ll='ls -la'
alias la='ls -lathr'

# Miscellaneous
alias t='tmux'
alias ta='tmux attach'
alias e='exit'
alias yt='yt-dlp'
alias pw='npx playwright'
alias gp='git pull'
alias gs='git status'
alias lg='lazygit'
alias ld='lazydocker'
alias ebr='v ~/.bashrc'
alias ea='v ~/.config/alacritty/alacritty.toml'
alias eg="v $DOTFILES/ghostty/config"
alias ek='v ~/.config/kitty/kitty.conf'
alias et='v ~/.tmux.conf'
alias ev='cd ~/.config/nvim/ && v init.lua'
alias sbr='source ~/.bashrc'
alias rob='v $REPOS/rwxrob/dot'
alias es='v ~/.config/starship.toml'
alias esk='v ~/.config/skhd/skhdrc'
alias eae='v ~/.config/aerospace/aerospace.toml'
alias tf='terraform'
alias tp='terraform plan'
alias python='python3'
alias k=kubectl
alias kubectl=kubecolor
source <(kubectl completion bash)
complete -o default -F __start_kubectl k
# complete -o default -F __start_kubectl k
alias kgp='kubectl get pods'
alias kgpo='kubectl get pods -o wide'
alias kc='kubectx'
alias kn='kubens'
alias ??='$DOTFILES/scripts/gpt'
alias nn='$DOTFILES/scripts/note'
alias icat="kitten icat"

# AWS profile aliases
alias mixa='export AWS_PROFILE=mixa && starship toggle aws'
alias slgfx='export AWS_PROFILE=slgfx && starship toggle aws'
alias mixa-e='export AWS_PROFILE=mixa-e && starship toggle aws'
alias vvcr-dev='export AWS_PROFILE=vvcr-dev-apps && starship toggle aws'
alias vvcr-stage='export AWS_PROFILE=vvcr-stage-apps && starship toggle aws'
alias vvcr-prod='export AWS_PROFILE=vvcr-prod-apps && starship toggle aws'
alias vvcr-dev-streamers='export AWS_PROFILE=vvcr-dev-streamers && starship toggle aws'
alias vvcr-stage-streamers='export AWS_PROFILE=vvcr-stage-streamers && starship toggle aws'
alias vvcr-prod-streamers='export AWS_PROFILE=vvcr-prod-streamers && starship toggle aws'
alias kolia='export AWS_PROFILE=kolia && starship toggle aws'

# gcloud alias
alias g='gcloud'

# Log aliases
alias logs-stage='aws logs tail /aws/elasticbeanstalk/vvcr-front-api-staging/var/log/web.stdout.log --follow --profile vvcr-stage-apps'
alias logs-dev='aws logs tail /aws/elasticbeanstalk/vvcr-front-api-dev/var/log/web.stdout.log --follow --profile vvcr-dev-apps'
alias logs-prod='aws logs tail /aws/elasticbeanstalk/vvcr-front-api-production/var/log/web.stdout.log --follow --profile vvcr-prod-apps'

# Streaming aliases
alias twitch='ffmpeg_loop ~/Movies/twitch.mp4'
alias timecode='ffmpeg_testsrc_live'
alias twitch60='ffmpeg_loop ~/Movies/twitch60.mp4'

# eks
# . <(eksctl completion bash)

# flux
source <(flux completion bash)
alias fgk='flux get kustomizations'

# talos
# source <(talosctl completion bash)

# EDB
# source <(kubectl-cnp completion bash)

# cilium
# source <(cilium completion bash)

# fzf aliases
alias ff="fzf --preview 'bat --style=numbers --color=always --line-range :501 {}'"
alias vf='v $(ff)'

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~
clone() {
    local repo="$1"
    local name="${repo##*/}"
    name="${name%.git}"
    local path="$HOME/Repos/$name"

    if [[ -d "$path" ]]; then
        cd "$path" || exit
        echo "Already cloned $name"
        return
    fi

    mkdir -p "$HOME/Repos"
    cd "$HOME/Repos" || exit
    echo gh repo clone "$repo" -- --recurse-submodule
    gh repo clone "$repo" -- --recurse-submodule
    cd "$name" || exit
}
export -f clone

sshf() {
local host="$(grep "^Host " ~/.ssh/config | awk '{print $2}' | fzf)"
ssh "$host"
}
export -f sshf

if [[ "$OSTYPE" == "darwin"* ]]; then
  source "$HOME/.fzf.bash"
  # echo "I'm on Mac!"

  # brew bash completion
  [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
else
  #	source /usr/share/fzf/key-bindings.bash
  #	source /usr/share/fzf/completion.bash

  # The first one worked on Ubuntu, the eval one on Fedora. Keeping for reference.
  # [ -f ~/.fzf.bash ] && source ~/.fzf.bash
  eval "$(fzf --bash)"
fi

# ------------------------- NVM bulshit------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/kolia/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

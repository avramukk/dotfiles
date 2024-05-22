# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/bashrc.pre.bash" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/bashrc.pre.bash"
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# starship
eval "$(starship init bash)"

# keybinds
bind -x '"\C-l":clear'
# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

# editor
export EDITOR="nvim"

# directories
export REPOS="$HOME/Repos"
export GITUSER="avramukk"
export GHREPOS="$REPOS/github.com/$GITUSER"
export XDG_CONFIG_HOME="$HOME/.config"
export DOTFILES="$REPOS/dotfiles"
export SCRIPTS="$DOTFILES/scripts"
export LAB="$REPOS/lab"
export KUBE_EDITOR="nvim"
# export SECOND_BRAIN="$HOME/second-brain"
export SECOND_BRAIN="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/second-brain"


# PATH
export GOBIN="$HOME/go/bin"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$DOTFILES/scripts:$PATH"
# OPENAI_API_KEY
declare OPENAI_API_KEY
OPENAI_API_KEY="$(head -1 "$XDG_CONFIG_HOME/gpt/token")"
export OPENAI_API_KEY

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.histfile
export HISTSIZE=100000
export SAVEHIST=100000
export HISTCONTROL=ignorespace
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"


# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias v=nvim

# cd
alias ..="cd .."
alias ..='cd ..'
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
alias rd='cd $REPOS/rwxrob/dot/'

#ls
alias ls='ls --color=auto'
alias l='ls -l'
alias ll='ls -la'
alias la='ls -lathr'

# finds all files recursively and sorts by last modification, ignore hidden files
alias last='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias sv='sudoedit'
alias t='tmux'
alias ta='tmux attach'
alias e='exit'
alias yt='yt-dlp'

# playwright
alias pw='npx playwright'

# git
alias gp='git pull'
alias gs='git status'
alias lg='lazygit'
alias ld='lazydocker'
# ricing
alias ebr='v ~/.bashrc'
alias ea='v ~/.config/alacritty/alacritty.toml'
alias et='v ~/.tmux.conf'
alias ev='cd ~/.config/nvim/ && v init.lua'
alias sbr='source ~/.bashrc'
alias es='v ~/.config/starship.toml'
alias esk='v ~/.config/skhd/skhdrc'
alias ey='v ~/.config/yabai/yabairc'

# terraform
alias tf='terraform'
alias tp='terraform plan'

# python
alias python='python3'

# kubectl
alias k='kubectl'
source <(kubectl completion bash)
complete -o default -F __start_kubectl k
alias kgp='kubectl get pods'
alias kgpo='kubectl get pods -o wide'
alias kc='kubectx'
alias kn='kubens'

# cw ai
alias ?='cw ai'
alias ??='$DOTFILES/scripts/gpt'

# second-brain
alias nn='$DOTFILES/scripts/note'

# alias for enabling aws prompt toggle ONLY when used export AWS_PROFILE
alias mixa='export AWS_PROFILE=mixa && starship toggle aws'
alias slgfx='export AWS_PROFILE=slgfx && starship toggle aws'
alias mixa-e='export AWS_PROFILE=mixa-e && starship toggle aws'
alias globex='export AWS_PROFILE=globex && starship toggle aws'
alias vvcr-dev='export AWS_PROFILE=vvcr-dev-apps && starship toggle aws'
alias vvcr-stage='export AWS_PROFILE=vvcr-stage-apps && starship toggle aws'
alias vvcr-prod='export AWS_PROFILE=vvcr-prod-apps && starship toggle aws'


# vvcr logs backend
alias logs-stage='aws logs tail /aws/elasticbeanstalk/vvcr-front-api-staging/var/log/web.stdout.log --follow --profile vvcr-stage-apps'
alias logs-dev='aws logs tail /aws/elasticbeanstalk/vvcr-front-api-dev/var/log/web.stdout.log --follow --profile vvcr-dev-apps'
alias logs-prod='aws logs tail /aws/elasticbeanstalk/vvcr-front-api-production/var/log/web.stdout.log --follow --profile vvcr-prod-apps'


# streaming
alias twitch='ffmpeg_loop ~/Movies/twitch.mp4'
alias timecode='ffmpeg_testsrc_live'
alias twitch60='ffmpeg_loop ~/Movies/twitch60.mp4'


# eks
# . <(eksctl completion bash)

# # flux
# source <(flux completion bash)
# alias fgk='flux get kustomizations'

# # talos
# source <(talosctl completion bash)

# # EDB
# source <(kubectl-cnp completion bash)

# # cilium
# source <(cilium completion bash)

# fzf aliases
# use fp to do an fzf search and preview the files
alias ff="fzf --preview 'bat --style=numbers --color=always --line-range :501 {}'"
# search for a file with fzf and open it in vim
alias vf='v $(ff)'

if [[ "$OSTYPE" == "darwin"* ]]; then
	source "$HOME/.fzf.bash"
	# echo "I'm on Mac!"

	[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
else
	#	source /usr/share/fzf/key-bindings.bash
	#	source /usr/share/fzf/completion.bash
	[ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/kolia/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# ------------------------- NVM bullshit ahead ------------------------
# (keep as is or nvm idiotic installer will re-add to bashrc next time)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completioneval "$(thefuck --alias)"

. "$HOME/.cargo/env"

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/bashrc.post.bash" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/bashrc.post.bash"

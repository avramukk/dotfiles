# CodeWhisperer pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/bashrc.pre.bash" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/bashrc.pre.bash"
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
export DOTFILES="$REPOS/dotfiles"
export SCRIPTS="$DOTFILES/scripts"
export LAB="$REPOS/lab"
export SECOND_BRAIN="$HOME/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/second-brain/"
export KUBE_EDITOR="nvim"

# PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$DOTFILES/scripts/:$PATH"

# PAT
export GOBIN="$HOME/go/bin"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
# OPENAI_API_KEY
declare OPENAI_API_KEY
OPENAI_API_KEY="$(head -1 "$HOME/.config/gpt/token")"
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
alias homelab='cd $REPOS/homelab/'
alias cv='cd $REPOS/avramukk.github.io/'
alias sb='cd -P $SECOND_BRAIN'
alias m='cd $REPOS/mischa'
alias md='cd $REPOS/mischa/dotfiles'

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

# eks
# . <(eksctl completion bash)
# alias kcs='kubectl config use-context admin@homelab-staging'
# alias kcp='kubectl config use-context admin@homelab-production'

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
export PATH="/Users/na/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && \. "/usr/local/opt/nvm/etc/bash_completion"

# CodeWhisperer post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/bashrc.post.bash" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/bashrc.post.bash"

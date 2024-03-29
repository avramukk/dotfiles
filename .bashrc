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

# config
export BROWSER=""

# editor
export EDITOR="nvim"

# directories
export REPOS="$HOME/Projects"
export GITUSER="avramukk"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$REPOS/dotfiles"
export LAB="$REPOS/lab"
export SCRIPTS="$DOTFILES/scripts"
export SECOND_BRAIN="$HOME/second-brain"
export KUBE_EDITOR=nvim
# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.histfile
export HISTSIZE=100000
export SAVEHIST=100000
export HISTCONTROL=ignorespace
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# tmuxifier
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

# Only run on Ubuntu
#

# if [[ -f /etc/os-release && $(grep -E "^(ID|NAME)=" /etc/os-release | grep -q "ubuntu")$? == 0 ]]; then
# 	eval "$(ssh-agent -s)" >/dev/null
# fi

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
alias hl='cd $REPOS/homelab'
alias hlp='cd $REPOS/github.com/na/homelab-private/'
alias hlps='cd $REPOS/github.com/na/homelab-private-staging/'
alias hlpp='cd $REPOS/github.com/na/homelab-private-production/'
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

# playwright
alias pw='npx playwright'

# git
alias gp='git pull'
alias gs='git status'
alias lg='lazygit'

# ricing
alias eb='v ~/.bashrc'
alias ea='v ~/.config/alacritty/alacritty.toml'
alias et='v ~/.tmux.conf'
alias ev='cd ~/.config/nvim/ && v init.lua'
alias sbr='source ~/.bashrc'
alias es='v ~/.config/starship.toml'
alias esk='v ~/.config/skhd/skhdrc'
alias ey='v ~/.config/yabairc'

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

# new tmux window mixa

alias mixa='tmuxifier load-window mixa'

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
alias vf='v $(fp)'

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

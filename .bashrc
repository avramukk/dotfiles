# CodeWhisperer pre block. Keep at the top of this file.
# [[ -f "${HOME}/Library/Application Support/codewhisperer/shell/bashrc.pre.bash" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/bashrc.pre.bash"

#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#PS1='[\u@\h \W]\$ '
PS1="\[\033[32m\]\w\[\033[33m\]\$(GIT_PS1_SHOWUNTRACKEDFILES=1 GIT_PS1_SHOWDIRTYSTATE=1 __git_ps1)\[\033[00m\] $ "
# Set to superior editing mode
# set -o vi

# keybinds
bind -x '"\C-l":clear'
# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

# config
export BROWSER="Arc"

# directories
export REPOS="$HOME/Projects"
export GITUSER="avramukk"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$REPOS/dotfiles"
export LAB="$REPOS/lab"
export SCRIPTS="$DOTFILES/scripts"

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~

# This function is stolen from rwxrob

clone() {
	local repo="$1" user
	local repo="${repo#https://github.com/}"
	local repo="${repo#git@github.com:}"
	if [[ $repo =~ / ]]; then
		user="${repo%%/*}"
	else
		user="$GITUSER"
		[[ -z "$user" ]] && user="$USER"
	fi
	local name="${repo##*/}"
	local userd="$REPOS/github.com/$user"
	local path="$userd/$name"
	[[ -d "$path" ]] && cd "$path" && return
	mkdir -p "$userd"
	cd "$userd"
	echo gh repo clone "$user/$name" -- --recurse-submodule
	gh repo clone "$user/$name" -- --recurse-submodule
	cd "$name"
} && export -f clone

# Only run on Ubuntu

# if [[ -f /etc/os-release && $(grep -E "^(ID|NAME)=" /etc/os-release | grep -q "ubuntu")$? == 0 ]]; then
# 	eval "$(ssh-agent -s)" >/dev/null
# fi

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias v=nvim

# cd
alias ..="cd .."
alias cdp='cd ~/Projects'
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

# ls
alias ls='ls --color=auto'
alias l='ls -la'
alias ll='ls -la'
alias la='ls -lathr'

# finds all files recursively and sorts by last modification, ignore hidden files
alias last='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias sv='sudoedit'
alias sk='killall ssh-agent && source ~/.zshrc'
alias t='tmux'
alias e='exit'
alias syu='sudo pacman -Syu'

# playwright
alias pw='npx playwright'
# git
alias gp='git pull'
alias gs='git status'
alias lg='lazygit'

# ricing
# alias et='v ~/.config/awesome/themes/powerarrow/theme-personal.lua'
# alias ett='v ~/.config/awesome/themes/powerarrow-dark/theme-personal.lua'
# alias er='v ~/.config/awesome/rc.lua'
# alias ez='v ~/.zshrc'
alias eb='v ~/.bashrc'
alias ev='cd ~/.config/nvim/ && v init.lua'
alias sbr='source ~/.bashrc'

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
alias kc='kubectx'
alias kn='kubens'

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
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
alias vf='v $(fp)'

# sourcing
# source "$HOME/.privaterc"

if [[ "$OSTYPE" == "darwin"* ]]; then
	source "$HOME/.fzf.bash"
	# echo "I'm on Mac!"

	# brew bash completion
	[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
else
	#	source /usr/share/fzf/key-bindings.bash
	#	source /usr/share/fzf/completion.bash
	[ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/na/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# export NVM_DIR="$HOME/.config/nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# CodeWhisperer post block. Keep at the bottom of this file.
# [[ -f "${HOME}/Library/Application Support/codewhisperer/shell/bashrc.post.bash" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/bashrc.post.bash"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
# if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
# 	debian_chroot=$(cat /etc/debian_chroot)
# fi

# set a fancy prompt (non-color, unless we know we "want" color)
# case "$TERM" in
# xterm-color | *-256color) color_prompt=yes ;;
# esac
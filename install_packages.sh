#!/bin/bash
#test
# Prompt the user to choose the OS
PS3="Please select your operating system: "
options=("Mac" "Ubuntu")

select opt in "${options[@]}"; do
	case $opt in
	"Mac")
		echo "Installing packages for Mac..."
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		brew install git node yarn python pipenv postgresql redis mongodb docker docker-compose kubectl helm awscli terraform packer ansible vault consul nomad vagrant alacritty tmux bash-git-prompt
		break
		;;
	"Ubuntu")
		echo "Installing packages for Ubuntu..."
		sudo apt update
		sudo apt install -y git nodejs npm python3 python3-pip pipenv postgresql redis mongodb docker docker-compose kubectl helm awscli terraform packer ansible vault consul nomad vagrant alacritty tmux ripgrep gh gcc g++ unzip fd fzf kubectx k9s lazygit neovim go
		break
		;;
	*) echo "Invalid option. Please try again." ;;
	esac
done

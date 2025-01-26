if [ -r ~/.bashrc ]; then
  source ~/.bashrc
fi

export XDG_CONFIG_HOME="$HOME"/.config

export BASH_SILENCE_DEPRECATION_WARNING=1

neofetch

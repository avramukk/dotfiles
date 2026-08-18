
# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/bash_profile.pre.bash" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/bash_profile.pre.bash"

# Only run on macOS

if [[ "$OSTYPE" == "darwin"* ]]; then
  # needed for brew
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi


if [ -r ~/.bashrc ]; then
  source ~/.bashrc
fi

export XDG_CONFIG_HOME="$HOME"/.config

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.bash 2>/dev/null || :

[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

export BASH_SILENCE_DEPRECATION_WARNING=1

export PATH="/opt/homebrew/opt/curl/bin:$PATH"


# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/bash_profile.post.bash" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/bash_profile.post.bash"

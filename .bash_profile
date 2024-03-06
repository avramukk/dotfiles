# Only run on macOS

if [[ "$OSTYPE" == "darwin"* ]]; then
  # needed for brew
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Only run these on Ubuntu

if [[ $(grep -E "^(ID|NAME)=" /etc/os-release | grep -q "ubuntu")$? == 0 ]]; then
  # needed for brew to work
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if [ -r ~/.bashrc ]; then
  source ~/.bashrc
fi

export XDG_CONFIG_HOME="$HOME"/.config

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/na/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
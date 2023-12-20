# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "wintermi/zsh-rust"
plug "chivalryq/git-alias"
plug "MichaelAquilina/zsh-you-should-use"
plug "wintermi/zsh-brew"

# Load and initialise completion system
autoload -Uz compinit
compinit

# Ensure less does not page if not necessary
export LESS="--no-init --quit-if-one-screen -R"

# zoxide

eval "$(zoxide init zsh)"

# fnm (Fast Node Manager)
eval "$(fnm env --use-on-cd)"

# Add bin to path
export GO_PATH=$HOME/go
export PATH=/opt/homebrew/opt/mysql-client/bin:HOME/bin:$GO_PATH/bin:$PATH

# Load fzf theme
source $HOME/.zsh/fzf-theme

# Add custom aliases
source $HOME/.zsh/aliases

# bit
export PATH="$PATH:/Users/tommarien/bin"
# bit end

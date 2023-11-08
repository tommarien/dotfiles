# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "wintermi/zsh-rust"
plug "chivalryq/git-alias"

fpath+="/opt/homebrew/share/zsh/site-functions"

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
export PATH=/opt/homebrew/opt/mysql-client/bin:HOME/bin:$PATH

# Add custom aliases
source $HOME/.zsh/aliases

# bit
export PATH="$PATH:/Users/tommarien/bin"
# bit end

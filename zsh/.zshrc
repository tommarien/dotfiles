# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-completions"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "wintermi/zsh-rust"
plug "chivalryq/git-alias"
plug "MichaelAquilina/zsh-you-should-use"
plug "wintermi/zsh-brew"
plug "Aloxaf/fzf-tab"
plug "jeffreytse/zsh-vi-mode"
#
# Load and initialise completion system
autoload -Uz compinit
if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

# Ensure less does not page if not necessary
export LESS="--no-init --quit-if-one-screen -R"

# zoxide
eval "$(zoxide init zsh)"

# fnm (Fast Node Manager)
eval "$(fnm env --use-on-cd --shell zsh)"

# direnv
eval "$(direnv hook zsh)"

# Add bin to path
export GO_PATH=$HOME/go
export PATH=/opt/homebrew/bin:$HOME/bin/scripts:/opt/homebrew/Caskroom/google-cloud-sdk/510.0.0/google-cloud-sdk/bin:$HOME/bin:$GO_PATH/bin:$PATH

# Load fzf theme
source $HOME/.zsh/fzf-onedark-darker-theme

# Add custom aliases
source $HOME/.zsh/aliases

# The zsh-vi-mode plugin will auto execute this function
function zvm_after_init() {
    # Fzf
    source <(fzf --zsh)
}

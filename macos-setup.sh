#!/usr/bin/env zsh

echo "Starting setup"

# Install xcode cli
if type xcode-select >&- && xpath=$( xcode-select --print-path ) &&
   test -d "${xpath}" && test -x "${xpath}" ; then
   echo "Skipping XCode CLI install already installed"
else
   echo "Installing XCode CLI"
   xcode-select --install
fi

# Install Zap
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1

# Check for Homebrew to be present, install if it's missing
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else 
    echo "Skipping homebrew, already installed"
fi

# Update homebrew recipes
echo "Updating homebrew"
brew update

PACKAGES=(
    awscli
    bat
    cmake
    delve
    direnv
    fd
    fnm
    fzf
    git
    git-trim
    goose
    hugo
    jq
    koekeishiya/formulae/skhd
    koekeishiya/formulae/yabai
    neovim
    readline
    ripgrep
    stow
    tlrc
    tmux
    tree-sitter
    wget
    zoxide
)
echo "Installing packages..."
brew install ${PACKAGES[@]} -q

echo "Installing cask..."
CASKS=(
   1password-cli
   appcleaner
   fork
   ghostty
   homerow
   kitty
   textmate
   tomatobar
)
echo "Installing cask apps..."
brew install --cask ${CASKS[@]} -q

echo "Configuring OS..."
# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

echo "You might need to install rust and golang manually"

echo "Macbook setup completed!"

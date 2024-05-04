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
    bat
    cmake
    direnv
    fnm
    fzf
    golang-migrate
    git
    git-trim
    goose
    hurl
    jq
    kitty
    neovim
    readline
    ripgrep
    koekeishiya/formulae/skhd
    stow
    tmux
    tree-sitter
    wget
    koekeishiya/formulae/yabai
    zoxide
)
echo "Installing packages..."
brew install ${PACKAGES[@]} -q

echo "Installing cask..."
CASKS=(
   cheatsheet
   fork
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

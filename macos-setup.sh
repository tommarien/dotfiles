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

# Install OMZ
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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
    efm-langserver
    fnm
    fzf
    git
    git-trim
    neovim
    readline
    ripgrep
    skhd
    starship
    stow
    tmux
    tree-sitter
    wget
    yabai
    zoxide
)
echo "Installing packages..."
brew install ${PACKAGES[@]} -q

echo "Installing cask..."
CASKS=(
   cheatsheet
   fork
   kitty
   textmate
)
echo "Installing cask apps..."
brew install --cask ${CASKS[@]} -q

echo "Configuring OS..."
# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

echo "Macbook setup completed!"

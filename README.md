# Dotfiles

## Install stow

```bash
# macOS - assumes Homebrew << https://brew.sh/ >> is installed
brew install stow
```

## Clone this repo in your home folder

```
git clone git@github.com:tommarien/dotfiles.git
```

## Run

```
cd ~/dotfiles

stow -t ~ stow

./install_env
```

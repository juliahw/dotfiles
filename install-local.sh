#!/usr/bin/env bash

# Make Bash not silently ignore errors.
set -euo pipefail

echo 'Installing Homebrew…'
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo 'Upgrading Homebrew packages…'
brew update
brew upgrade

echo 'Installing Git…'
brew install git

echo 'Installing Alacritty…'
# `--no-quarantine` bypasses macOS's Gatekeeper so we can open Alacritty without a warning (see
# https://github.com/alacritty/alacritty/issues/4673).
brew install alacritty --no-quarantine

echo 'Installing Python3…'
brew install python@3.10

echo 'Installing ripgrep...'
brew install ripgrep

echo 'Installing zsh...'
brew install zsh
brew install zsh-completions

echo 'Setting the login shell to zsh…'
sudo chsh -s "$(which zsh)" "$(whoami)" < /dev/tty

echo 'Installing oh-my-zsh…'
rm -rf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" \
    --unattended

echo 'Installing tmux…'
brew install tmux

echo 'Installing Visual Studio Code…'
brew install visual-studio-code

echo 'Installing the Input font…'
cp "input-font/Input_Fonts/Input/"* ~/Library/Fonts

echo 'Installing dotfiles…'
cp  ".tmux.conf" ~/.tmux.conf
cp  ".zshrc" ~/.zshrc
rm -rf ~/.config/alacritty
mkdir -p ~/.config/alacritty
cp -r ".config/alacritty" ~/.config
rm -rf ~/.config/base16-shell
mkdir -p ~/.config/base16-shell
cp -r ".config/base16-shell" ~/.config
mkdir -p ~/Library/Application\ Support/Code/User/
cp "vscode/settings.json" ~/Library/Application\ Support/Code/User/

echo 'Setting the Base16 Shell color scheme…'
zsh -ic base16_circus

echo 'Reloading tmux config…'
tmux source-file ~/.tmux.conf || true # Only succeeds if tmux is running

echo 'Done.'

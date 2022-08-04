#!/bin/bash
ln -sf ~/dotfiles/.gitconfig ~
ln -sfn ~/dotfiles/.vim ~/.config/nvim
ln -sf ~/dotfiles/.zshrc ~
vscode="$HOME/.config/Code - OSS/User"
mkdir -p "$vscode"
ln -sf ~/dotfiles/.vscode/settings.json "$vscode"
ln -sf ~/dotfiles/.vscode/keybindings.json "$vscode"

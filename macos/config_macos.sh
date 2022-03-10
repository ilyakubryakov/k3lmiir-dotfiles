#!/bin/bash
info_msg "...Now installing several of useful console applications..."
brew bundle --file="$HOME/k3lmiir_dotfiles/macos/brew/Brewfile" || true

info_msg "...Now installing several Extensions to VSCode..."
code_ext_list=$(cat "$HOME/k3lmiir_dotfiles/vscode/vscode_extensions_list")
for i in $code_ext_list; do
    info_msg "...Installing '$i' extension..."
    "${code_path[@]}" --install-extension "$i"
done
#!/bin/bash
branch='develop'
brew_bundle_url="https://raw.githubusercontent.com/ilyakubryakov/k3lmiir-dotfiles/$branch/macos/brew/Brewfile"
code_path=("/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code")
code_ext_url="https://raw.githubusercontent.com/ilyakubryakov/k3lmiir-dotfiles/$branch/vscode/vscode_extensions_list"
printf "$FMT_YELLOW %s • Please make sure you have installed Xcode Command Line tools\n $FMT_RESET"
printf "$FMT_YELLOW %s • Read here how to do that: https://mac.install.guide/commandlinetools/index.html\n $FMT_RESET"
printf '\n'

read -p "$FMT_BLUE $FMT_BOLD Are you sure? Y/n  $FMT_RESET" -n 1 -r
echo 

if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 
fi

info_msg "Install Homebrew"
info_msg "On next lines Homebrew's install script will ask enter password. Please enter password from your mac user!"
#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

info_msg "...Now installing several of useful console applications..."
/bin/bash -c "$(curl $brew_bundle_url --output /tmp/Brewfile)"
brew bundle --file=/tmp/Brewfile || true
rm -rf /tmp/brew_pkg

info_msg "...Now installing several Extensions to VSCode..."
/bin/bash -c "$(curl $code_ext_url --output /tmp/vscode_extensions_list)"
code_ext_list=$(cat /tmp/vscode_extensions_list)
for i in $code_ext_list; do
    info_msg "...Installing "$i" extension..."
    "${code_path[@]}" --install-extension "$i"
done
rm -rf /tmp/vscode_extensions_list
#!/bin/bash
printf "$FMT_YELLOW %s • Please make sure you have installed Xcode Command Line tools\n $FMT_RESET"
printf "$FMT_YELLOW %s • Read here how to do that: https://mac.install.guide/commandlinetools/index.html\n $FMT_RESET"
printf '\n'

read -p "$FMT_BLUE $FMT_BOLD Are you sure? Y/n  $FMT_RESET" -n 1 -r
echo    # (optional) move to a new line

if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 
fi

info_msg "Install Homebrew"
info_msg "On next lines Homebrew's install script will ask enter password. Please enter password from your mac user!"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

info_msg "...Now installing several of useful console applications..."
/bin/bash -c "$(curl  https://raw.githubusercontent.com/ilyakubryakov/macos/brew/brew_pkg --output /tmp/brew_pkg)"
for i in $(cat /tmp/brew_pkg); do
    info_msg "Installing $i"
    brew install --cask "$i"
done
rm -rf brew_cask.txt



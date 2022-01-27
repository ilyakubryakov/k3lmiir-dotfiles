#!/bin/bash
#Check Xcode-select installed and install Homebrew
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

#Install brew's
/bin/bash -c "$(curl  https://raw.githubusercontent.com/ilyakubryakov/macos_ya.p_initial_config/main/brew.txt --output brew.txt)"
for i in $(cat brew.txt); do
    brew install "$i" 
done
rm -rf brew.txt

#Install brew casks
/bin/bash -c "$(curl  https://raw.githubusercontent.com/ilyakubryakov/macos_ya.p_initial_config/main/brew_cask.txt --output brew_cask.txt)"
for i in $(cat brew_cask.txt); do 
    brew install --cask "$i" 
done
rm -rf brew_cask.txt

#Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#Install python requirements
/bin/bash -c "$(curl https://raw.githubusercontent.com/ilyakubryakov/macos_ya.p_initial_config/main/requirements_python.txt --output requirements_python.txt)"
pip3 install -r requirements_python.txt
rm -rf requirements_python.txt

#Install VSCode extentions 
/bin/bash -c "$(curl https://raw.githubusercontent.com/ilyakubryakov/macos_ya.p_initial_config/main/vscode_extensions_list.txt --output vscode_extensions_list.txt)"
code="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
cat vscode_extensions_list.txt | xargs -L 1 $code --install-extension
rm -rf vscode_extensions_list.txt
osascript -e 'display dialog "All done! You cool! 🍺" buttons {"Yeah"}'

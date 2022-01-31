#!/bin/bash
info_msg "...Now installing oh-my-zsh with plugins..."
ohmyzsh_dir_check="$(ls -A "$HOME"/.oh-my-zsh)" 
if [ -z "$ohmyzsh_dir_check" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-completions "$HOME"/.oh-my-zsh/custom/plugins/zsh-completions
    git clone git://github.com/zsh-users/zsh-autosuggestions "$HOME"/.zsh/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME"/.zsh/zsh-syntax-highlighting
    git clone https://github.com/bhilburn/powerlevel9k.git "$HOME"/.oh-my-zsh/custom/themes/powerlevel9k
else
    wrn_msg "...Seems oh-my-zsh already installed"
fi

info_msg "...Now install and configure VIM..."
rm -rf "$HOME"/.vim/autoload "$HOME"/.vim/bundle || true
mkdir -p "$HOME"/.vim/autoload "$HOME"/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git "$HOME"/.vim/bundle/Vundle.vim
curl -LSso "$HOME"/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git clone https://github.com/scrooloose/nerdtree.git "$HOME"/.vim/bundle/nerdtree
rm -rf  "$HOME"/.vim/colors/wombat "$HOME"/.vim/colors/
git clone https://github.com/sheerun/vim-wombat-scheme.git "$HOME"/.vim/colors/wombat
mv "$HOME"/.vim/colors/wombat/colors/* "$HOME"/.vim/colors/

info_msg "...Now install and configure Yandex.Cloud CLI..."
curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash

read -p "$FMT_BLUE $FMT_BOLD Do you want to change your default shell? y/n $FMT_RESET" -n 1 -r
printf ''
if [[ $REPLY =~ ^[Yy]$ ]]
then
	info_msg "Now setting default shell..."
    zsh_p=$(which zsh)
    chsh -s "$zsh_p"; exit 0
    if ! 0
    then
        info_msg "Successfully set your default shell to zsh..."
    else
        echo "$FMT_RED %s Default shell not set successfully... $FMT_RESET" >&2
fi
else 
    echo "$FMT_RED" "You chose not to set your default shell to zsh. Exiting now... ""$FMT_RESET"
fi

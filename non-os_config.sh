#!/bin/bash
info_msg "...Now installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

info_msg "...Now installing some nice Oh-My-Zsh plugins"
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

info_msg "...Now installing powerlevel9k..."
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

info_msg "...Now installing vundle..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

info_msg "...Now installing Pathogen..."
if [ ! -d "$HOME/.vim/autoload" ] || [ ! -d "$HOME/.vim/bundle" ]
then
    mkdir -p "$HOME"/.vim/autoload "$HOME"/.vim/bundle
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
else
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

info_msg "...Now installing Nerdtree for Vim..."
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

info_msg "...Now installing vim wombat color scheme..."
git clone https://github.com/sheerun/vim-wombat-scheme.git "$HOME"/.vim/colors/wombat
mv "$HOME"/.vim/colors/wombat/colors/* "$HOME"/.vim/colors/

read -p "$FMT_BLUE $FMT_BOLD Do you want to change your default shell? y/n $FMT_RESET" -n 1 -r
printf ''
if [[ $REPLY =~ ^[Yy]$ ]]
then
	info_msg "Now setting default shell..."
    zsh_p=$(which zsh)
    chsh -s "$zsh_p"; exit 0
    if [[ $? -eq 0 ]]
    then
        info_msg "Successfully set your default shell to zsh..."
    else
        echo "$FMT_RED %s Default shell not set successfully... $FMT_RESET" >&2
fi
else 
    echo "$FMT_RED" "You chose not to set your default shell to zsh. Exiting now... ""$FMT_RESET"
fi
#!/bin/bash
info_msg "On next lines script will ask enter password. Please enter password from your user! (sudo)"
info_msg "...Update packages and Upgrade system..."
sudo apt-get update -y
pkg_list='git wget curl mc nmap zsh mongodb-clients vim  shellcheck python3.9 snap gnupg software-properties-common'
info_msg "...Install list of pkgs..."
sudo apt -y install "$pkg_list"
info_msg "...Install terraform..."
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update
sudo apt-get install terraform
sudo snap install code --classic
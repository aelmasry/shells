#!/bin/bash
# run it as sudo yes | sh ubuntu_software_installer.sh

cd ~

#update & upgrade
sudo apt update && sudo apt upgrade -y

# CURL
sudo apt-get install curl

#Remove Firefox Snap
sudo apt remove --purge firefox

#add Mozilla team PPA
sudo add-apt-repository ppa:mozillateam/ppa

#set Mozilla team PPA as high Priority
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/firefox

#block the Ubuntu repo
echo '
Package: firefox*
Pin: release o=Ubuntu*
Pin-Priority: -1
' | sudo tee /etc/apt/preferences.d/firefox

#set Firefox for automatic updates 
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

sudo apt update

sudo apt install firefox

#Install Ubuntu Restricted Extras
sudo apt install ubuntu-restricted-extras

#Minimize on Click
gsettings set org.gnome.shell.extensions.dash-to-dock click-action minimize

#Flatpak
sudo apt install gnome-software gnome-software-plugin-flatpak flatpak

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

#Extensions and Tweaks

sudo apt install gnome-tweaks gnome-shell-extensions gnome-shell-extension-manager -y

# CHROME
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb -y
sudo apt -f install

# wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
# sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

# VS CODE 
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt install -y code terminator git kodi vim


# NVM
curl https://raw.githubusercontent.com/creationix/nvm/v0.33.4/install.sh | bash

# NODE
nvm install stable

## GIT config
git config --global user.email "ali.elmasery@gmail.com"
git config --global user.name "Ali Salem"

# AVN
npm install -g avn avn-nvm avn-n
avn setup

#install docker & docker compose
sudo apt install apt-transport-https ca-certificates curl software-properties-common

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install docker-ce -y

sudo usermod -aG docker ${USER}

sudo usermod -aG docker ali

sudo curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

sudo chown root:docker /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

#Install PHP8.1
sudo apt install --no-install-recommends php8.1 -y

sudo apt-get install -y php8.1-{cli,fpm,mysql,common,curl,mbstring,opcache,readline,xml,zip,bcmath,gd,gettext,ctype}

sudo apt-get install -y libnss3-tools jq xsel 

# Install composer
curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php

HASH=`curl -sS https://composer.github.io/installer.sig`

php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

composer global require cpriego/valet-linux

test -d ~/.composer && bash ~/.composer/vendor/bin/valet install || bash ~/.config/composer/vendor/bin/valet install

#Install Wine
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key

sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/focal/winehq-focal.sources
sudo apt update

sudo apt install --install-recommends winehq-stable -y

bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

##NodeJs
sudo apt install -y nodejs npm

sudo apt-get update && sudo apt-get install -y ca-certificates curl gnupg
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update && sudo apt-get install nodejs -y

sudo apt update

#update & upgrade
sudo apt update && sudo apt upgrade -y


echo Finished Installing Programs!

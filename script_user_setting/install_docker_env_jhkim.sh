#!/bin/bash

HOME_DIRECTORY="/my_home"

# cp /mnt/user/<shared_user>/_settings/install_user.sh ./install_user.sh
# sudo addgroup --gid 1000 admin
# sudo useradd -m -g admin -G sudo -u 1012 -s /bin/bash <target_user>

# sudo apt-get update
# sudo apt-get install -y zsh curl git autojump

chsh -s /usr/bin/zsh 
echo "lllp" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

ln -s /mnt/user/<shared_user> ~/workspace_link

mv ~/.zshrc ~/.zshrc_org
ln -s /mnt/user/<shared_user>/_settings/.zshrc ~/.zshrc

mv ~/.vimrc ~/.vimrc_org
ln -s /mnt/user/<shared_user>/_settings/.vimrc ~/.vimrc

source ~/.zshrc
source /opt/conda/bin/activate
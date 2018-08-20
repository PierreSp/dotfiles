# dotfiles

## Usage
###  Installation

- Install yay and pacman programs
```bash
inst yay otf-font-awesome fish powerline powerline-fonts tmux ttf-font-awesome xcape otf-fira-code vlc
```
- Install programs from AUR
```bash
yay -S powerline py3status  dropbox sublime-text-dev redshift-gtk

```
- Install dotdrop and load all configs (Make sure the host is correct)
```bash
git clone --recursive https://github.com/nathbo/dotfiles.git ~/dotfiles
cd ~/dotfiles
pip install --user -r dotfiles/requirements.txt
./dotdrop.sh install
```

- Install oh my fish and set theme
```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -L https://get.oh-my.fish | fish
omf install agnoster
```

- Install plug for neovim 
```bash
pip3 install --user --upgrade neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

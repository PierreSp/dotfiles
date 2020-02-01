# dotfiles

## Usage
###  Installation

- Install dotdrop and load all configs (Make sure the host is correct)
```bash
export DOTREPO="~/dotfiles"
alias dotdrop="$DOTREPO/dotdrop.sh"

git clone --recursive https://github.com/PierreSp/dotfiles ~/dotfiles
cd ~/dotfiles
pip install --user -r dotfiles/requirements.txt
./dotdrop.sh install
```

- Install fonts and gui stuff AUR
	- xcape for reconfiguration of keys
```bash
yay -S otf-font-awesome powerline powerline-fonts ttf-font-awesome xcape otf-fira-code adobe-source-code-pro-fonts nordic-theme-git 

```

- Install essential programs from AUR
	- kitty as terminal emulator
	- python-pipx to make python packages available everywhere
```bash
yay -S kitty python-pipx julia emacs neovim dropbox sublime-text-dev

```

- Install terminal tools from AUR
	- bat as cat replacement
	- mons for simple multi-monitor settings
	- ripgrep as faster grep
	- fd as faster find
	- glances as better htop
	- cloc for code statistics

```bash
yay -S bat ripgrep mons fd sshfs py3status glances cloc

```

- Install optional programs from AUR
	- redshift to filter blue light in the evening
```bash
yay -S asciinema asciiquarium redshift-gtk-git signal-desktop vlc pandoc

```

- Install oh my fish and set theme
```bash
curl -L https://get.oh-my.fish | fish
omf install bobthefish
```



- Install python tools
```bash
sh dotfiles/scripts/install_py_packages.sh
```
- Neovim:
	Get Plugvim with:
	```bash
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	```
	Run :PlugInstall
	and :PlugUpdate in nvim
Alternative font idea: https://github.com/be5invis/Iosevka

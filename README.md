# dotfiles

## Usage
###  Installation

- Install dotdrop and load all configs (Make sure the host is correct)
```bash
git clone --recursive https://github.com/nathbo/dotfiles.git ~/dotfiles
cd ~/dotfiles
pip install --user -r dotfiles/requirements.txt
./dotdrop.sh install
```

- Install yay and pacman programs
```bash
inst yay otf-font-awesome fish powerline powerline-fonts tmux ttf-font-awesome xcape otf-fira-code vlc bat ripgrep
```
- Install programs from AUR
```bash
yay -S powerline py3status  dropbox sublime-text-dev redshift-gtk vidir

```

- Install oh my fish and set theme
```bash
curl -L https://get.oh-my.fish | fish
omf install agnoster
```

- Install python tools for neovim 
```bash
pip install --user --upgrade neovim
pip install --user --upgrade jedi
pip install --user --upgrade black
```
    - Run :PlugInstall withhin neovim
## Used tools and programs

- vidir # Vi-based multi file renaming tool (AUR)
- neovim # Better vim
- fish # Shell extension (used with oh-my-fish and agnoster theme)
- tmux # Terminal multiplexer 
- Dropbox
- xcape # redefine keys
- yay # better yaourt (package manager for AUR)
- ripgrep # better grep
- bat # better cat
- vlc # good video player
- sublime # good coding environment
- redshift # protects your eyes
- powerline # show more information in terminal
- kitty # gui based, ssh friendly terminal emulator
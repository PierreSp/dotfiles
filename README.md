# dotfiles

## Usage
###  Installation

- Install dotdrop and load all configs (Make sure the host is correct)
```bash
git clone --recursive https://github.com/PierreSp/dotfiles ~/dotfiles
cd ~/dotfiles
pip install --user -r dotfiles/requirements.txt
./dotdrop.sh install
```

- Install yay and pacman programs
```bash
inst yay otf-font-awesome fish powerline powerline-fonts tmux ttf-font-awesome xcape otf-fira-code vlc bat ripgrep asciinema mons asciiquarium rofi adobe-source-code-pro-fonts
```
- Install programs from AUR
```bash
yay -S powerline py3status dropbox sublime-text-dev redshift-gtk signal-desktop vidir

```

- Install oh my fish and set theme
```bash
curl -L https://get.oh-my.fish | fish
omf install agnoster
```

- Install python tools (will ask for different setups (data science, autocomplete, stats)
```bash
sh dotfiles/scripts/install_py_packages.sh
```
- Run :PlugInstall withhin neovim
## Used tools and programs

- asciinema - *Best video studio ever*
- asciiquarium - *Relaxing screensaver*
- bat - *better cat*
- Dropbox
- fish - *Shell extension (used with oh-my-fish with agnoster theme and virtualfish for python envs)*
- kitty - *gui based, ssh friendly terminal emulator*
- mons - *Good wrapper for randr*
- neovim - *Better vim*
- powerline - *show more information in terminal*
- redshift - *protects your eyes*
- rofi - dmenu alternative
- ripgrep - *better grep*
- sublime - *good coding environment*
- signal  -  Desktop application for signal
- tmux - *Terminal multiplexer*
- vidir - *Vi-based multi file renaming tool (AUR)*
- vlc - *good video player*
- xcape - *redefine keys*
- yay - *better yaourt (package manager for AUR)*

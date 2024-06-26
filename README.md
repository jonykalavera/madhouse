# Madhouse

Jony Kalavera's, chezmoi dot-files repo.

# Quick setup

Install required tools. For arch:
```bash
sudo pacman -Sy chezmoi
sudo pacman -Sy fzf
sudo pacman -Sy fd
sudo pacman -Sy bat
sudo pacman -Sy btop
sudo pacman -Sy neovim
sudo pacman -Sy nvm
sudo pacman -Sy tldr
sudo pacman -Sy dust
sudo pacman -Sy git-delta
git clone git@github.com:junegunn/fzf-git.sh.git .fzf-git.sh
```

Restore dot-files with `chezmoi`.
```
chezmoi init git@github.com:jonykalavera/madhouse.git
chezmoi update -v
```
For more details check https://www.chezmoi.io/user-guide/command-overview/#daily-commands

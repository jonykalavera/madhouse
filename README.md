# Madhouse

Jony Kalavera's, chezmoi dot-files repo.

# Quick setup

Install required tools. For arch:
```bash
sudo pacman -Sy chezmoi fzf fd bat btop neovim nvm tldr dust git-delta btop
git clone git@github.com:junegunn/fzf-git.sh.git .fzf-git.sh
pip install jedi pynvim --user
```

Restore dot-files with `chezmoi`.
```
chezmoi init git@github.com:jonykalavera/madhouse.git
chezmoi update -v
```
For more details check https://www.chezmoi.io/user-guide/command-overview/#daily-commands

SHELL := /bin/bash

clean-downloads:
	# https://github.com/risabhRizz/DownloadsOrganizer
	cd Downloads && java -jar DownloadsOrganizer.jar

install:	
	sudo pacman -Sy chezmoi fzf fd bat btop neovim tldr dust git-delta btop tmux tmuxp zoxide ripgrep pyenv lazygit
	if [[ ! -d $$HOME/.fzf-git.sh ]]; then git clone git@github.com:junegunn/fzf-git.sh.git .fzf-git.sh; fi
	cd .config/nvim
	if [[ ! -d ~/.config/nvim/venv ]]; then python -m venv venv; fi
	$$HOME/.config/nvim/venv/bin/pip install -r $$HOME/.config/nvim/requirements.txt
	if [[ ! -d ~/.tmux/plugins/tpm ]]; then git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; fi
	if [[ ! -f ~/.emoji-prompt.sh ]]; then curl 'https://raw.githubusercontent.com/jonykalavera/emoji-prompt/master/emoji-prompt.sh' > ~/.emoji-prompt.sh; fi
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh


chezmoi-all:
	chezmoi re-add
	chezmoi git -- add .
	chezmoi git -- commit -m "Auto-add-all 💀 from $$(hostname)"
	chezmoi git -- push

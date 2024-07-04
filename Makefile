SHELL := /bin/bash

clean-downloads:
	# https://github.com/risabhRizz/DownloadsOrganizer
	cd Downloads && java -jar DownloadsOrganizer.jar

install:	
	sudo pacman -Sy chezmoi fzf fd bat btop neovim nvm tldr dust git-delta btop tmux tmuxp kitty zoxide
	if [[ ! -d $$HOME/.fzf-git.sh ]]; then git clone git@github.com:junegunn/fzf-git.sh.git .fzf-git.sh; fi
	cd .config/nvim
	if [[ ! -d ~/.config/nvim/venv ]]; then python -m venv venv; fi
	$$HOME/.config/nvim/venv/bin/pip install -r $$HOME/.config/nvim/requirements.txt
	if [[ ! -d ~/.tmux/plugins/tpm ]]; then git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; fi
	if [[ ! -f ~/.emoji-prompt.sh ]]; then curl 'https://raw.githubusercontent.com/heewa/emoji-prompt/master/emoji-prompt.sh' > ~/.emoji-prompt.sh; fi

chezmoi-all:
	chezmoi re-add
	chezmoi git -- add .
	chezmoi git -- commit -m "Auto-add-all 💀"
	chezmoi git -- push

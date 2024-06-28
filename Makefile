SHELL := /bin/bash

clean-downloads:
	# https://github.com/risabhRizz/DownloadsOrganizer
	cd Downloads && java -jar DownloadsOrganizer.jar

install:	
	sudo pacman -Sy chezmoi fzf fd bat btop neovim nvm tldr dust git-delta btop
	if [[ ! -d $$HOME/.fzf-git.sh ]]; then git clone git@github.com:junegunn/fzf-git.sh.git .fzf-git.sh; fi
	cd .config/nvim
	if [[ ! -d $$HOME/.config/nvim/venv ]]; then python -m venv venv; fi
	$$HOME/.config/nvim/venv/bin/pip install -r $$HOME/.config/nvim/requirements.txt


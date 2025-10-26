#!/bin/bash
[[ -e ".tmuxp.yaml" ]] && tmuxp load -a . && tmux kill-window -t :0
yazi

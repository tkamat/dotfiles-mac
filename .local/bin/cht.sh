#!/usr/bin/env zsh
selected=$(cat ~/.tmux-cht-languages ~/.tmux-cht-command | fzf)
if [[ -z $selected ]]; then
    exit 0
fi

read "query?Enter Query: "

if grep -qs "$selected" ~/.tmux-cht-languages; then
    query=$(echo $query | tr ' ' '+')
    tmux neww zsh -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while true; do sleep 1; done"
else
    tmux neww zsh -c "curl -s cht.sh/$selected~$query | less"
fi

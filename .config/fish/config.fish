# fzf:
# - set the default options to have the search bar on top
# - make it use ripgrep instead of find + show hidden folders
# - set the default key bindings
# - undo fzf's keybind for Ctrl-r
set -x FZF_DEFAULT_OPTS "--layout=reverse"
set -x FZF_CTRL_T_COMMAND 'rg --hidden --files'

fzf_key_bindings
bind \cr history-pager

# disable fish startup message
set -x fish_greeting

# set alias for git .dotfiles repo
alias config='/usr/bin/git --git-dir=$HOME/Projects/.dotfiles/ --work-tree=$HOME'

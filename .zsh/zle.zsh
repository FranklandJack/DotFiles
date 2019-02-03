# This file contains zle (zsh line editor) related stuff 
# e.g. custom widgets and keymap bindings
# to be sourced in .zhrc at startup.


# Bind \eg to git status.
# Function that clears command line and executes git status.
function _git_status {
        zle kill-whole-line
        zle -U "git status"
        zle accept-line
}
# Add function as a widget.
zle -N _git_status
# Bind widget to keyboard shortcut.
bindkey '\eg' _git_status

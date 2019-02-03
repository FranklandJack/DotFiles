# Sets up prompt, to be sourced in .zshrc at startup.
autoload -Uz promptinit
promptinit

setopt prompt_subst

autoload colors && colors
OPEN_BRA="%{$fg_bold[cyan]%}[%{$reset_color%}"
CLOSE_BRA="%{$fg_bold[cyan]%}]%{$reset_color%}"
USER_NAME="%B%F{red}%n%b%f"
WORK_DIR="%{$fg_bold[green]%}%~%{$reset_color%}"
PRIVLIGE="%{$fg_bold[white]%}%#%{$reset_color%}"
EXIT_STATUS="%(?..${OPEN_BRA}%B%F{red}%?%b%f${CLOSE_BRA})"
PROMPT_END="%B%F{white}: %b%f"

PS1="${OPEN_BRA}${USER_NAME}${CLOSE_BRA}${OPEN_BRA}${WORK_DIR}${CLOSE_BRA}${EXIT_STATUS}${OPEN_BRA}${PRIVLIGE}${CLOSE_BRA}${PROMPT_END}"
# Widgets for displaying mode when using vim mode.

# Function that sets the right side prompt to contain a yellow [NORMAL]
# if we are in normal mode  and the git branch so it looks like 
# (left side prompt)                            [NORMAL] [master].
#
function _zle_line_init _zle_keymap_select {
        autoload colors && colors
        # The part of the prompt containing the [NORMAL] if in normal mode.
        VIM_PROMPT="${OPEN_BRA}%{$fg_bold[yellow]%}NORMAL%{$reset_color%}${CLOSE_BRA}"
        # Setting the right side prompt.
        RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
        # Redraw the prompt when this function is finished.
        zle reset-prompt
}

# Register this widget and replace the builtin zle-line-init 
# and zle-keymap-select
# (zle-line-init is executed every time the line editor is started 
# to read a new line of input, zle-keymap-select executed every time 
# the keymap changes, i.e. the special parameter KEYMAP is set to a 
# different value, while the line editor is active. Initialising the 
# keymap when the line editor starts does not cause the widget to be called. 
# This can be used for detecting switches between the vi command (vicmd) and insert (usually main) keymaps.
zle -N zle-line-init  _zle_line_init
zle -N zle-keymap-select _zle_keymap_select

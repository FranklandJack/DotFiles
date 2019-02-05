# Sets up prompt, to be sourced in .zshrc at startup.
# Widgets for displaying mode when using vim mode.
autoload -Uz promptinit && promptinit

setopt prompt_subst

autoload -Uz colors && colors

# Function to change color of variables based on whether in normal 
# or insert mode.
function _zle_line_init _zle_keymap_select {
        # Colors required for this.
        autoload colors && colors
        # Color in insert mode.
        INSERT_COLOR="%B%F{white}"
        # Color of normal mode.
        NORMAL_COLOR="%B%F{yellow}"
        # Set current color based on mode.
        CURRENT_COLOR="${${KEYMAP/vicmd/${NORMAL_COLOR}}/(main|viins)/${INSERT_COLOR}}"

        RESET_COLOR="%b%f"
        OPEN_BRA="%{$fg_bold[cyan]%}[%{$reset_color%}"
        CLOSE_BRA="%{$fg_bold[cyan]%}]%{$reset_color%}"
        USER_NAME="%B%F{red}%n%b%f"
        WORK_DIR="%{$fg_bold[green]%}%1d%{$reset_color%}"
        PRIVLIGE="${CURRENT_COLOR}%#${RESET_COLOR}"
        EXIT_STATUS="%(?..${OPEN_BRA}%B%F{red}%?%b%f${CLOSE_BRA})"
        PROMPT_END="%B%F{white}: %b%f"

        PS1="${OPEN_BRA}${USER_NAME}${CLOSE_BRA}${OPEN_BRA}${WORK_DIR}${CLOSE_BRA}${EXIT_STATUS}${OPEN_BRA}${PRIVLIGE}${CLOSE_BRA}${PROMPT_END}"
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

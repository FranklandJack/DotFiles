# Set up the prompt
eval "$(starship init zsh)"

# Enable super glob.
setopt extended_glob

setopt histignorealldups sharehistory

# Use vim keybindings.
bindkey -v
# By default, there is a 0.4 second delay after you hit the <ESC> key 
# and when the mode change is registered, this fixes that.
export KEYTIMEOUT=1

# Useful keybindings from emacs mode that aren't available by 
# default with vim mode.

# Use vim cli mode.
bindkey '^P' up-history
bindkey '^N' down-history

# Backspze and ^h working even after returning from command mode.
bindkey '^?' backward-delete-char

# ctrl-w removed word backwards
bindkey '^w' backward-kill-word

# ctrl-b move back single char.
bindkey '^b' backward-char

# ctrl-a move to end of line.
bindkey '^a' end-of-line

# crtl-e move to beginning of line.
bindkey '^e' beginning-of-line

# ctrl-r starts searching history backward
bindkey '^r' history-incremental-search-backward

# ctrl-o clear terminal (like ctrl-l but that is now mapped for moving around
# vim and tmux)
bindkey '^o' clear-screen

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
if [[ "$OSTYPE" == "linux-gnu" ]]; then
        eval "$(dircolors -b)"
fi
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Source all my aliases
if [ -f ~/.bash/bash_aliases ]; then
    . ~/.bash/bash_aliases
fi

# for fuzzy finder.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# show hidden files and use fd as find command.
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
if [[ $(uname) == "Darwin" ]]; then
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --no-ignore --exclude .git --exclude .clangd'
elif command -v apt > /dev/null; then
export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --no-ignore --exclude .git --exclude .clangd'
else
  echo 'Unknown OS! cannot use fd/fdfind!'
fi

# Source zle configurations.
source ~/.zsh/zle.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zpty is required for autocomplete to suggest what tab complete would suggest.
zmodload zsh/zpty 
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Auto-complete configuration.

# Completion strategy suggestion order.
ZSH_AUTOSUGGEST_STRATEGY=(completion match_prev_cmd history)

# Wont auto-suggest beyond 20 characters.
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" autosuggest-accept   # [Shift-Tab] - complete autosuggestion.
fi

# For ccache
if [[ $(uname) == "Darwin" ]]; then
  export PATH="/opt/homebrew/opt/ccache/libexec:$PATH"
elif command -v apt > /dev/null; then
  export PATH="/usr/lib/ccache:$PATH"
else
  echo 'Unknown OS! cannot append ccache path to PATH!'
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

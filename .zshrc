# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

## History command configuration
setopt extended_history       # record timestamp(UNIX) of command in HISTFILE
setopt histignorealldups      # ignore duplicated commands history list
setopt sharehistory           # shared history witch other users
setopt histignorespace        # remove commands which startwith space

setopt correct                # autocorrect

setopt autopushd              # Push the current directory visited on the stack.
setopt pushdignoredups        # Do not store duplicates in the stack.
setopt pushdsilent            # Do not print the directory stack after pushd or popd.

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -v

bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char

# Use modern completion system
autoload -Uz compinit
compinit
_comp_options+=(globdots) # searches files even if they begin with a dot

source "$ZDOTDIR/aliases"
source "$ZDOTDIR/themes/powerlevel10k/powerlevel10k.zsh-theme"

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# search commands in history which startwitch in cursor CLI

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search


[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# forward/backword world

#key[Control-Left]="${terminfo[kLFT5]}"
#key[Control-Right]="${terminfo[kRIT5]}"

#[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
#[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word

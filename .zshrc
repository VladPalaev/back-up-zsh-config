# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

## History command configuration
setopt extended_history       # record timestamp(UNIX) of command in HISTFILE
setopt histignoredups         # enter command lines into the history list if they are duplicates of the previous event.
setopt sharehistory           # shared history with other users
setopt histignorespace        # remove commands which startwith space

setopt correct                # confirm corrected command prompt
setopt menucomplete           # Display the completion menu after two use of the  key

setopt autopushd              # Push the current directory visited on the stack.
setopt pushdignoredups        # Do not store duplicates in the stack.

setopt globdots               # include hidden files in tab completion
## aliases in file .config/zsh/.aliases
source "$ZDOTDIR/.aliases"
## theme powerlevel10k
source "$XDG_DATA_HOME/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme"

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Use modern completion system
zmodload zsh/complist        # !required for correct operation bind key menu select
autoload -Uz compinit
compinit

bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char

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

## Using a cache for the completion can speed up some commands
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/.zcompcache


# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

##
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

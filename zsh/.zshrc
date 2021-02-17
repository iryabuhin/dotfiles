# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Autostart X
# if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#   exec startx
# fi

# Stuff borrowed from manjaro-zsh-config
setopt correct                                      # Auto correct mistakes
setopt extendedglob                                 # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                   # Case insensitive globbing
setopt rcexpandparam                                # Array expension with parameters
#setopt nocheckjobs                                 # Don't warn about running processes when exiting
setopt numericglobsort                              # Sort filenames numerically when it makes sense
setopt nobeep                                       # No beep
setopt appendhistory                                # Immediately append history instead of overwriting
setopt histignorealldups                            # If a new command is a duplicate, remove the older one
setopt autocd                                       # if only directory path is entered, cd there.

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion

zstyle ':completion:*' accept-exact '*(n)'
zstyle ':completion:*' use-cache on

WORDCHARS=${WORDCHARS//\/[&.;]}                     # Don't consider certain characters part of the word

# Load colors
autoload -U compinit colors zcalc
compinit -d
colors

# load zgen
source "$HOME/.zgen/zgen.zsh"
# if the init script doesn't exist
if ! zgen saved; then

  # specify plugins here
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/pip
  zgen oh-my-zsh plugins/sudo
  zgen oh-my-zsh plugins/tmux

  # theme
  # zgen oh-my-zsh themes/clean
  

  # generate the init script from plugins above
  zgen save
fi
zgen load romkatv/powerlevel10k powerlevel10k
COMPLETION_WAITING_DOTS="true"

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

# Load dir colors
test -r "~/.dircolors" && eval $(dircolors ~/.dircolors)

zmodload zsh/terminfo
# Use history substring search
# bind UP and DOWN arrow keys to history substring search
# bindkey "$terminfo[kcuu1]" history-substring-search-up
# bindkey "$terminfo[kcud1]" history-substring-search-down
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down


# Enable VIM mode
bindkey -v
export KEYTIMEOUT=1

zstyle ':completion:*' menu select
zmodload zsh/complist
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
bindkey '^w' backward-kill-word

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^p' edit-command-line

_comp_options+=(globdots)

#alias runkali='sudo docker run -ti --rm --mount src=kali-root,dst=/root --mount src=kali-postgres,dst=/var/lib/postgresql my-kali'


ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

[[ -e "/usr/share/fzf/fzf-extras.zsh" ]] && source /usr/share/fzf/fzf-extras.zsh
export FZF_DEFAULT_COMMAND="fd --type file --color=always --follow --hidden --exclude .git"
# Uncomment the following line to disable fuzzy completion
# export DISABLE_FZF_AUTO_COMPLETION="true"

# Uncomment the following line to disable key bindings (CTRL-T, CTRL-R, ALT-C)
# export DISABLE_FZF_KEY_BINDINGS="true"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

ZSH_PLUGINS=('zsh-syntax-highlighting' 'zsh-autosuggestions')
ZSH_PLUGINS_DIR="/usr/share/zsh/plugins"
ZSH_SHARE_DIR="/usr/share/zsh"

for plugin in $ZSH_PLUGINS; do
    if [ -d $ZSH_PLUGINS_DIR ]; then
        source "$ZSH_PLUGINS_DIR/$plugin/$plugin.zsh"
    else
        source "/usr/share/$plugin/$plugin.zsh"
    fi
done

[[ -f $HOME/.zsh_aliases ]] && . $HOME/.zsh_aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

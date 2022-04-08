# Constants
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$HOME/.custom_scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Read my aliases file
. ~/.aliases
# Run my login scripts
# . ~/.custom_scripts/startup

# Command history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Vim mode
bindkey -v
export KEYTIMEOUT=1

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

# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!**/{build,.git,gen,.class,bin,coverage,node_modules}/**" 2> /dev/null'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!**/{build,.git,bin,coverage,node_modules}/**" 2> /dev/null'

# Automatically add fzf key bindings to .zshrc
# source /usr/share/fzf/key-bindings.zsh
/usr/local/opt/fzf/install

# PROMPT
source ~/.zsh_prompt

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# zsh-syntax-highlighting must be at the bottom
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

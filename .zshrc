export LANG=en_US.UTF-8

source ~/.zplug/init.zsh

# zplug
zplug "mafredri/zsh-async", from:github

zplug load

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Add pip packages to path
export PATH=/Users/joonas/Library/Python/3.8/bin:$PATH

# ls colors and aliases for macOS
export CLICOLOR=1
alias ll='ls -l'
alias la='ls -la'

# Disable ctrl+d EOF
setopt ignore_eof

# Brew completions
if type brew &>/dev/null; then
  export PATH="/usr/local/sbin:$PATH"
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# Asdf support
. /usr/local/opt/asdf/libexec/asdf.sh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# prezto history module
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing non-existent history.

#
# Variables
#

HISTFILE="${HISTFILE:-${ZDOTDIR:-$HOME}/.zhistory}"  # The path to the history file.
HISTSIZE=10000                   # The maximum number of events to save in the internal history.
SAVEHIST=10000                   # The maximum number of events to save in the history file.

#
# Aliases
#

# Lists the ten most used commands.
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

# Created by `pipx` on 2023-10-24 11:18:14
export PATH="$PATH:/Users/joonas/.local/bin"
alias awsume=". awsume"

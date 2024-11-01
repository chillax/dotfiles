# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/joonas/.zsh/completions:"* ]]; then export FPATH="/Users/joonas/.zsh/completions:$FPATH"; fi
# Note: Put PATH stuff to .zshenv

# History
HISTFILE="${HISTFILE:-${ZDOTDIR:-$HOME}/.zhistory}"
HISTSIZE=10000
SAVEHIST=10000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Case insensitive completion
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Setup fzf
source <(fzf --zsh)

# Setup asdf
. "$HOME/.asdf/asdf.sh"
export ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY=latest_installed # Support for legacy .nvmrc non-exact version numbers e.g. v18 points to latest installed 18.x.x

# ls colors and aliases
export CLICOLOR=1
alias ll='ls -l'
alias la='ls -la'

# Disable ctrl+d EOF (accidentally exiting shell)
setopt ignore_eof
. "/Users/joonas/.deno/env"
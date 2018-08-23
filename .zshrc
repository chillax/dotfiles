export LANG=en_US.UTF-8

source ~/.zplug/init.zsh

# zplug
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "modules/history", from:prezto

zplug load

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

# Add pip packages to path
export PATH=/Users/joonas/Library/Python/3.7/bin:$PATH


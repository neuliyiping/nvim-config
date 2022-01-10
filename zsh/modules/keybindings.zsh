# ZSH Keybindings
zmodload zsh/complist
autoload edit-command-line

WIDGETS=(edit-command-line fzf-open-file-in-editor fzf-cd-to-dir fzf-git-switch-branch)

for widget ($WIDGETS) zle -N $widget

bindkey "${KEYBIND_PREFIX}b" fzf-git-switch-branch
bindkey "${KEYBIND_PREFIX}c" fzf-cd-to-dir
bindkey "${KEYBIND_PREFIX}f" fzf-open-file-in-editor
bindkey '^ ' autosuggest-accept
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^N' down-history
bindkey '^O' accept-line
bindkey '^P' up-history
bindkey '^x^e' edit-command-line

bindkey -M menuselect ' ' accept-search
bindkey -s "${KEYBIND_PREFIX}gf" "git-feature "
bindkey -s '^x^x' "clear ^o"
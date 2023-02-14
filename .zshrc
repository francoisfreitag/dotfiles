export EDITOR=/usr/bin/nvim
alias vim=nvim
alias fixup='git commit --fixup `fsha` 2>/dev/null'
alias rg='rg --hidden'

export PATH="$(systemd-path user-binaries):$HOME/bin:$PATH"

export HISTSIZE=100000000
export SAVEHIST=100000000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS

# Display active virtualenv
grml_theme_add_token venv -f virtualenv_prompt '%F{magenta}' '%f'

function virtualenv_prompt () {
    REPLY=${VIRTUAL_ENV+(${VIRTUAL_ENV:t}) }
}
zstyle ':prompt:grml:left:setup' items rc venv change-root path vcs percent

# Start tmux
if [ -z "$TMUX" ]; then
    tmux
fi

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source "$HOME/.zshrc.fzf"

eval "$(direnv hook zsh)"

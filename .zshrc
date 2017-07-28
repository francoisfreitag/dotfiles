export SAVEHIST=100000000
export EDITOR=/usr/bin/nvim
set -o vi
alias vim=nvim

export PATH=$HOME/bin/:$HOME/.npm-packages/bin:$PATH

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/dev/
source /usr/bin/virtualenvwrapper.sh

# Setup antigen
source /usr/share/zsh/share/antigen.zsh

antigen bundle Tarrasch/zsh-autoenv
antigen bundle pip
antigen apply

# Display active virtualenv
grml_theme_add_token venv -f virtualenv_prompt '%F{magenta}' '%f'

function virtualenv_prompt () {
    REPLY=${VIRTUAL_ENV+(${VIRTUAL_ENV:t}) }
}
zstyle ':prompt:grml:left:setup' items rc venv change-root user at host path vcs percent

# Start tmux
if [ -z "$TMUX" ]; then
    tmux
fi

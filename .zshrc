export EDITOR=/usr/bin/vim
export PATH=$HOME/bin/:$HOME/.npm-packages/bin:$PATH
# Should fix SSH keyring problems...
export SSH_AUTH_SOCK=/run/user/1000/keyring/ssh
alias atr='atr --live'
alias edit_translations='git status |grep modified | grep ".po" | grep "fr" | cut -d: -f2 | xargs poedit'
alias pyma='python manage.py'
source /usr/bin/virtualenvwrapper.sh
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/dev/

# Display active virtualenv
grml_theme_add_token venv -f virtualenv_prompt '%F{magenta}' '%f'

function virtualenv_prompt () {
    REPLY=${VIRTUAL_ENV+(${VIRTUAL_ENV:t}) }
}
zstyle ':prompt:grml:left:setup' items rc venv change-root user at host path vcs percent

set -o vi

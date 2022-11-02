# Path to the oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

# The oh-my-zsh theme to load
ZSH_THEME="agnoster"

# Load oh-my-zsh.
source "$ZSH/oh-my-zsh.sh"

# Only show the last component of the path.
prompt_dir() {
  prompt_segment blue black '%1~'
}

# Override the Agnoster theme's built-in prompt.
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_dir
  prompt_git
  prompt_end
}

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# fzf
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '"'!*.git/'"'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh || true

# Local configuration
if [ -f "$HOME/.zshrc-local" ]; then
  source "$HOME/.zshrc-local"
fi

# Aliases
alias gco='git checkout'

# Functions
function die {
  tmux kill-server
}

function ga {
  git commit --all --amend --no-edit
  git status
}

function gap {
  git commit --all --amend --no-edit
  git push --force
  git status
}

function gfp {
  git push --force
}

function current-branch {
  git rev-parse --abbrev-ref HEAD 2> /dev/null
}

function default-branch {
  echo main
}

function update-repo {
  if [ "$(current-branch)" = "$1" ]; then
    git pull
  else
    git fetch origin "$1:$1"
  fi

  git fetch --prune
}

function gr {
  update-repo "$(default-branch)"
  git rebase "$(default-branch)"
  git status
}

function close {
  BRANCH="$(current-branch)"
  git checkout "$(default-branch)"
  git pull
  git branch -D "$BRANCH"
}

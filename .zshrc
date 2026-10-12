# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=false
plugins=(git zsh-syntax-highlighting you-should-use tmux zsh-bat zsh-autosuggestions vi-mode)

source "$ZSH/oh-my-zsh.sh"

alias vi="nvim"
alias notes="cd ~/notes;vi"
alias gminor='gcam "minor" && git rebase -i HEAD~2'
alias oc="opencode"

export EDITOR="nvim"
export NVM_DIR="$HOME/.nvm"

nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  nvm "$@"
}

node() {
  unset -f nvm node npm npx
  \. "$NVM_DIR/nvm.sh"
  nvm use default --silent
  node "$@"
}

npm() {
  unset -f nvm node npm npx
  \. "$NVM_DIR/nvm.sh"
  nvm use default --silent
  npm "$@"
}

npx() {
  unset -f nvm node npm npx
  \. "$NVM_DIR/nvm.sh"
  nvm use default --silent
  npx "$@"
}

FZF_ALT_C_COMMAND= FZF_CTRL_T_COMMAND= source <(fzf --zsh)

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

eval "$(zoxide init --cmd cd zsh)"

export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$HOME/.opencode/bin:$PATH"

[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

source ~/gitstatus/gitstatus.prompt.zsh
export PATH="$HOME/.git-ai/bin:$PATH"

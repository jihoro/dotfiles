# zmodload zsh/zprof
plugins=(git zsh-syntax-highlighting you-should-use tmux zsh-bat zsh-autosuggestions vi-mode)
#ZSH_TMUX_AUTOSTART=true
#ZSH_TMUX_DEFAULT_SESSION_NAME=default

alias k="kubectl"
alias kx="kubie ctx"
alias kn="kubie ns"
alias kgp="kubectl get pods"
alias kgs="kubectl get svc"
alias kgd="kubectl get deployment"
alias vi="nvim"
alias notes="cd ~/notes;vi"

FZF_CTRL_T_COMMAND= source <(fzf --zsh)
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
eval "$(zoxide init --cmd cd zsh)"

# zprof

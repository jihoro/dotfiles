plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-bat you-should-use tmux)
#ZSH_TMUX_AUTOSTART=true
#ZSH_TMUX_DEFAULT_SESSION_NAME=default


alias k="kubectl"
alias kx="kubie ctx"
alias kxc="kubie ctx cfctl-pdx-c"
alias kn="kubie ns"
alias kgp="kubectl get pods"
alias kgs="kubectl get svc"
alias kgd="kubectl get deployment"
export PATH=$PATH:$HOME/go/bin:$HOME/Downloads/nvim-macos-arm64/bin
set -o vi
source <(fzf --zsh)

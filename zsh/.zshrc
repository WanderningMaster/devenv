export ZSH=/home/andrii/.oh-my-zsh
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/zig-linux
export PATH=$PATH:~/.cargo/bin
export PATH="$HOME/go/bin:$PATH"

export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"

# bindkey "^L" clear-screen


# If you come from bash you might have to change your $PATH.

# fwalch
# minimal
# eastwood
ZSH_THEME="fwalch"

plugins=(
	git
	zsh-autosuggestions
)

# User configuration

source $ZSH/oh-my-zsh.sh
# source /usr/share/fzf/key-bindings.zsh
# source /usr/share/fzf/completion.zsh
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

tmr() {
	tmux new-session -d
	echo "Restoring..."
	while ! tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh; do sleep 0.2; done
}
tmux-here() {
    local session_name=${PWD##*/}  # Get the current directory name
    tmux new -s "$session_name"  # Create a new tmux session with the directory name
}
tmfzf() {
	selected_dir=$(fzf --reverse --walker=dir,follow,hidden --scheme=path)

	if [ -z "$selected_dir" ]; then
		echo "No directory selected."
		return
	fi

	cd "$selected_dir"
	dir_name=$(basename "$(pwd)")
	tmux new-session -s "$dir_name"
}
switch-config() {
  case "$1" in
    outsource) EMAIL=andrii.h@brightnode.io; SSH_KEY=~/.ssh/github_outsource ;;
    cgs)       EMAIL=andrew.h@cgsteam.io;    SSH_KEY=~/.ssh/cgs             ;;
    *)         EMAIL=user12341528@gmail.com; SSH_KEY=~/.ssh/github_personal ;;
  esac

  eval "$(ssh-agent -s)"
  ssh-add -D
  ssh-add "$SSH_KEY"
  git config --global user.email "$EMAIL"
}

function kill-port {
	sudo kill -9 $(lsof -i :$1 | grep LISTEN | awk '{print $2}')
}

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias ohmyzsh="mate ~/.oh-my-zsh"
# alias nvim="/opt/nvim-linux64/bin/nvim"
alias zshconfig="nvim ~/.zshrc"
alias ta="tmux a -t"
alias tk="tmux kill-session -t"
alias v="nvim ."
alias air="$(go env GOPATH)/bin/air"
alias tls="tmux ls"
alias cls="clear"

alias devon="nmcli con up AOutsource"
alias devoff="nmcli con down AOutsource"

# g shell setup
if [ -f "${HOME}/.g/env" ]; then
    . "${HOME}/.g/env"
fi

export PATH=/opt/nvim-linux64/bin/nvim:$PATH
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/home/andrii/zig

export CDPATH=".:$HOME:$HOME/.config/:$HOME/.local/:$HOME/.locale/share/:$HOME/.locale/programs"
export EDITOR="vim"
PROMPT='%B%F{008} Debian %B%F{007}%~%B%F{006} >>%b%F{015} '
RPROMPT='%B%F{006}$(parse_git_branch)%F{003}$(parse_git_dirty) %B%F{015}%t'
precmd() { print "" }
autoload -Uz compinit
setopt PROMPT_SUBST
compinit
zstyle ':completion:*' menu select
source $HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.config/zsh/plugins/spectrum/spectrum.zsh

###-------------------- PROMPT ------------------------###
##							##
##							##
parse_git_dirty() {
	STATUS="$(git status 2> /dev/null)"
	if [[ $? -ne 0 ]]; then printf ""; return; else printf " ["; fi
	if echo "${STATUS}" | grep -c "renamed:"		&> /dev/null; then printf " >"; else printf ""; fi
	if echo "${STATUS}" | grep -c "branch is ahead:"	&> /dev/null; then printf " !"; else printf ""; fi
	if echo "${STATUS}" | grep -c "Untracked files:"	&> /dev/null; then printf " ?"; else printf ""; fi
	if echo "${STATUS}" | grep -c "new file::"		&> /dev/null; then printf " +"; else printf ""; fi
        if echo "${STATUS}" | grep -c "modified:"		&> /dev/null; then printf " *"; else printf ""; fi
	if echo "${STATUS}" | grep -c "deleted:"		&> /dev/null; then printf " -"; else printf ""; fi
	printf " ]"
}

parse_git_branch() {
	# Long form
	git rev-parse --abbrev-ref HEAD 2> /dev/null
	# Short form
	# git rev-parse --abbrev-ref HEAD 2> /dev/null | sed -e 's/.*\/\(.*\)/\1/'
}
# XDG paths
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}

# initialize autocompletion
autoload -U compinit
compinit

# history setup
setopt APPEND_HISTORY
setopt SHARE_HISTORY
HISTFILE=$HOME/.config/zsh/.zsh_history
SAVEHIST=1000
HISTSIZE=999
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY

# autocompletion using arrow keys (based on history)
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

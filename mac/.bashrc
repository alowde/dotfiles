# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

parse_git_branch() {
  git branch 2> /dev/null | gsed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/' | awk -v len=40 '{ if (length($0) > len) print substr($0, 1, len-3) "..."; else print; }'
}


PS1='\u@\h:\[\033[32m\]\w\[\033[33m\]$(parse_git_branch)\[\033[00m\]$ '

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

alias ansve="ansible-vault edit --vault-password-file=~/.ssh/ansible-vault"
alias sshsock="export SSH_AUTH_SOCK=~/.ssh/auth_sock"

complete -C '/usr/bin/aws_completer' aws

export BASH_SILENCE_DEPRECATION_WARNING=1
export EDITOR=nvim

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH=$PATH:$HOME/.SpaceVim/bin
export PATH=$PATH:$HOME/Library/Python/3.9/bin

echo "sourced .bashrc"

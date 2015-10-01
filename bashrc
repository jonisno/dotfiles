case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth

shopt -s histappend

HISTSIZE=100000
HISTFILESIZE=2000000

shopt -s checkwinsize

#shopt -s globstar

case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

#Enable colours for man page.
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;208m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[0m'

# Set dbic profile.
export DBIC_TRACE_PROFILE=console

# Grep with colours
alias grep="grep --colour"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


perlbrew="$HOME/perl5/perlbrew/etc/bashrc"
if [ -r "$perlbrew" -a -f "$perlbrew" ] ; then
	source "$perlbrew"
fi

# Add some aliases to navigate reach.
REACH="$HOME/workspaces/reach/webapp"
if [ -d $REACH ] ; then
	alias rs="cd $REACH/lib/Reach/Schema/Result"
	alias templates="cd $REACH/templates"
	alias js="cd $REACH/public/js"
	alias rlib="cd $REACH/lib/Reach"
	alias api="cd $REACH/lib/Reach/Api/V1"
	alias apitests="cd $REACH/tests/api/v1"
	alias tests="cd $REACH/tests"
	alias sql="cd $REACH/sql/migrations"
	alias reach="cd $REACH"
	alias ptest="MOJO_LOG_LEVEL=fatal MOJO_MODE=testing prove -Pretty -vlr"
fi

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../../'
alias .....='cd ../../../..'

. ~/.private/*

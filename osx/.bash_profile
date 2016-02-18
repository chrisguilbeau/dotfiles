export PATH="/Users/cg/bin:/usr/local/bin:$PATH"
export CLICOLOR=1
export GREP_COLOR="auto"
export PS1="\[\e[0;35m\]\u@\h:\[\e[0;34m\]\w\$ \[\e[m\]"
export EDITOR=vim
export LSCOLORS=ExFxBxDxCxegedabagacad

alias zz="cd ~/z/proj/"\`z?\`
alias z="cd ~/z"
alias zoom='osascript ~/bin/zoom.scpt'
alias ll="ls -la"
# alias vim='nvim'

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# added by Anaconda 2.2.0 installer
export PATH="/Users/cg/anaconda/bin:$PATH"

# added by Anaconda2 2.4.0 installer
export PATH="/Users/cg/anaconda/bin:$PATH"

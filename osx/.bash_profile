export PATH="~/bin:/usr/local/bin:$PATH"
export CLICOLOR=1
export GREP_COLOR="auto"
export PS1="\[\e[0;35m\]\u@\h:\[\e[0;34m\]\w\$ \[\e[m\]"
export EDITOR=vim

# history shared across terminal sessions!
shopt -s histappend
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTCONTROL=ignoredups:erasedups
export PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"

# added by Anaconda 2.0.1 installer
export PATH="/Users/cg/anaconda/bin:$PATH"

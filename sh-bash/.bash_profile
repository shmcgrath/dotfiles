[[ "-f $HOME/.bashrc" ]] && source $HOME/.bashrc && echo 'sourcing $HOME/.bashrc'
[[ "-f $HOME/.cargo/env" ]] && source $HOME/.cargo/env && echo 'sourcing $HOME/.cargo/env'
[[ "-f $XDG_CONFIG_HOME/sh-base/ssh-agent-auth-socket" ]] && source $XDG_CONFIG_HOME/sh-base/ssh-agent-auth-socket && echo 'sourcing $XDG_CONFIG_HOME/sh-base/ssh-agent-auth-socket'

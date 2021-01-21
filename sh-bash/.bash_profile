if [ -d "$HOME/.scripts" ]; then
	PATH="$HOME/.scripts:${PATH}"
	echo 'PATH: $PATH'
fi

if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:${PATH}"
	echo 'PATH: $PATH'
fi

if [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc && echo 'sourcing $HOME/.bashrc'
fi


# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH

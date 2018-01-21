# NOT ALIASES BUT HELPFUL ANYWAY
# include aliases for git
if [ -f ~/.bash_aliases_git ]; then
    . ~/.bash_aliases_git
fi

# for ignoring certain commands to appear on history, add colon to separate commands
HISTIGNORE='git status:gis:git pull:gip:clear:exit:ls'

# enable GIT BRANCH to display on command line
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[01;32m\]\u \[\033[01;34m\]\w\[\033[01;33m\]\$(parse_git_branch)\[\033[00m\] $ "

# quick directory movement
alias ..='cd ..';
alias ...='cd ../..';
alias ....='cd ../../..';
alias .....='cd ../../../..';
alias resource='source ~/.bashrc';

alias askrm='rm -i';

# print the current time
alias now='date +%T';

# edit the selected bash config file
function editbash {
    if [[ "$1" == "a" ]]; then
        subl ~/.bash_aliases;
    elif [[ "$1" == "h" ]]; then
        subl ~/.bash_history;
    elif [[ "$1" == "g" ]]; then
        subl ~/.bash_aliases_git;
    #elif [[ "$1" == "f" ]]; then
    #    subl ~/.bash_functions
    else
        subl ~/.bashrc;
    fi
}

goto () {
    echo "cd ~/Projects/php/$1*";
    cd ~/Projects/php/$1*;
}

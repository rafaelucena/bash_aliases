#GIT COMMANDS
# simple aliases
alias gibr='git branch';
alias gime='git merge master';
alias gipu='git pull';  #down <==
alias gist='git status';

# complex aliases
# git upstream
giup () {
    #If first variable is null, don't go forward
    if [[ -z "$1" ]]; then
        echo "COMMAND INVALID! MUST HAVE AT LEAST ONE VARIABLE!";
    else
        #If second variable is null
        if [[ -z "$2" ]]; then
            #Set the second variable equal to the first one
            set $1 $1;
        fi
        git branch --set-upstream-to=origin/$1 $2;
    fi
}
# git checkout
gico () {
    #If first variable is null, checkout master.
    if [[ -z "$1" ]]; then
        git checkout master;
        git pull;
    else
        git checkout $1;
    fi
}
# git diff
gidf () {
    if [[ -z "$1" ]]; then
        git diff;
    else
        git diff *$1;
    fi
}
# git add
giad () {
    if [[ -z "$1" ]]; then
        echo "COMMAND INVALID! MUST HAVE AT LEAST ONE VARIABLE!";
    else
        git add *$1;
    fi
}
# git push #up   ==>
gipx () {
    git pull;
    git push;
}
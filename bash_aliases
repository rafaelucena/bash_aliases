# NOT ALIASES BUT HELPFUL ANYWAY
# include aliases for git
if [ -f ~/.bash_aliases_internal ]; then
    . ~/.bash_aliases_internal
fi
if [ -f ~/.bash_aliases_git_internal ]; then
    . ~/.bash_aliases_git_internal
fi
if [ -f ~/.bash_aliases_git ]; then
    . ~/.bash_aliases_git
fi

# for ignoring certain commands to appear on history, add colon to separate commands
HISTIGNORE='git status:gis:git pull:gip:clear:exit:ls'

# enable GIT BRANCH to display on command line
get_git_branch () {
    #git symbolic-ref --short HEAD;

    local branchPrefix='';
    local branchSufix='';

    case $1 in
        'type_a')
            branchPrefix=' >';
            branchSufix='<';
            ;;
        'type_b')
            branchPrefix=' :';
            branchSufix=':';
            ;;
        'type_c')
            branchPrefix=' (';
            branchSufix=')';
            ;;
        '')
            ;;
    esac

    git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/$branchPrefix\1$branchSufix/";
}
export PS1="\[\033[01;32m\]\u \[\033[01;34m\]\w\[\033[01;33m\]\$(get_git_branch type_b)\[\033[00m\] $ "

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

function dye {
    local color='';

    case $1 in
        'black')
            color='\033[0;30m';;
        'red' )
            color='\033[0;31m';;
        'green' )
            color='\033[0;32m';;
        'orange' )
            color='\033[0;33m';;
        'blue' )
            color='\033[0;34m';;
        'purple' )
            color='\033[0;35m';;
        'cyan' )
            color='\033[0;36m';;
        'light_gray' )
            color='\033[0;37m';;
        'light_green' )
            color='\033[1;32m';;
        'yellow' )
            color='\033[1;33m';;
        'light_blue' )
            color='\033[1;34m';;
        'white' )
            color='\033[1;37m';;
        'undye')
            color='\033[0m';;
        *)
            local usage='';

            usage="$(dye black)black$(dye undye)";
            usage="$usage|$(dye yellow)yellow$(dye undye)";
            usage="$usage|$(dye orange)orange$(dye undye)";
            usage="$usage|$(dye red)red$(dye undye)";
            usage="$usage|$(dye light_green)light_green$(dye undye)";
            usage="$usage|$(dye green)green$(dye undye)";
            usage="$usage|$(dye cyan)cyan$(dye undye)";
            usage="$usage|$(dye light_blue)light_blue$(dye undye)";
            usage="$usage|$(dye blue)blue$(dye undye)";
            usage="$usage|$(dye purple)purple$(dye undye)";
            usage="$usage|$(dye light_gray)light_gray$(dye undye)";
            usage="$usage|$(dye white)white$(dye undye)";
            usage="$usage|$(dye undye)undye$(dye undye)";

            echo -e "Usage: $ dye {$usage}";
            return;;
    esac

    echo $color;
}

readonly GOTO_MAP_FILE='/home/user/.goto_map.xml';
readonly GOTO_TEST_FILE='/home/user/test.xml';

function goto () {
    tags=($(grep -oP '(?<=tag>)[^<]+' ${GOTO_MAP_FILE}))
    paths=($(grep -oP '(?<=path>)[^<]+' ${GOTO_MAP_FILE}))

    for i in ${!tags[*]}; do
        if [[ "${tags[${i}]}" == "${1}"* ]]; then
            echo "cd" "${paths[${i}]}" "(${tags[${i}]})";
            cd "${paths[${i}]}";
            break;
        fi
    done
}

function mapme () {
    local tagPath=$(__mapme_generate_tag_path);
    local tagName=$(__mapme_generate_tag_name "${1}");

    __mapme_insert_tags 'print';
}

function _mapme_test () {
    local tagName='';
    if [ -n "${1}" ]; then
        tagName="${1}";
    else
        local basePath=${PWD##*/};
        tagName=${basePath,,};
    fi

    echo $(sed -n  "\|${tagName}|=" $(__mapme_file 'test'));
    #check if tag/address already exist on the file
        #if so, do something
        #if else; do great
}
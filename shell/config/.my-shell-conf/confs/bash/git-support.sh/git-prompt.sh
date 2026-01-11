function parse_git_branch() {
    git branch --show-current 2> /dev/null | sed -n -e 's/^\(.*\)/[git:\1]/p'
}

COLOR_DEF='\[\033[0m\]'
COLOR_GIT='\[\033[38;5;39m\]'
export PS1="${PS1}${COLOR_GIT}\$(parse_git_branch)${COLOR_DEF}"

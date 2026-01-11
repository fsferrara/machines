function parse_git_branch() {
    git branch --show-current 2> /dev/null | sed -n -e 's/^\(.*\)/[git:\1]/p'
}

COLOR_DEF=$'%f'
COLOR_GIT=$'%F{39}'
setopt PROMPT_SUBST
PROMPT_CWD='${COLOR_GIT}$(parse_git_branch)${COLOR_DEF}'
export PROMPT="${PROMPT}${PROMPT_CWD}"

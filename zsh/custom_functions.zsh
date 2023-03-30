#!/usr/bin/zsh

function dots() {
    tmux new-window -c "$DOTFILES"
}

function public-ip() {
    local PUBLIC_IP=$(curl -sL v4.ifconfig.co | awk '{ print $0 "/32" }')
    echo $PUBLIC_IP
}

function src() {
    exec zsh
}

function owl() {
    echo
    echo "{o,o}"
    echo "./)_)"
    echo '  ""'
    echo
}

function kitty-cat() {
    echo ""
    echo '  /\___/\'
    echo " ( o   o )"
    echo " (  =^=  )"
    echo " (        )"
    echo " (         )"
    echo " (          )))))))))))"
    echo ""
}

function search() {
    search_string="https://duckduckgo.com/?q="

    for word in $*; do
        search_string+="${word}+"
    done

    open $search_string
}

function docker() {
    if [[ $@ == "ps" ]]; then
        command docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}\t{{.Networks}}\t{{.Ports}}"
    elif [[ $@ == "stop all" ]]; then
        command docker stop $(docker ps -q)
    else
        command docker "$@"
    fi
}

function pyclean() {
    find . -regex '^.*\(__pycache__\|\.py[co]\)$' -delete
}

function install-poetry-project() {
    pip install poetry
    poetry install
}

function install-sugar {
    pip install pytest-sugar pytest-xdist ipdb
}

function upgrade-pip() {
    pip install pip --upgrade
}

function git-jira() {
    local JIRA_URL=$1
    local BRANCH_NAME=$2
    local FULL_BRANCH_NAME
    local ISSUE_ID

    ISSUE_ID=$(echo $JIRA_URL | grep -oP '\KSAS-\d+$')

    if [[ ! -z "$BRANCH_NAME" ]]; then
        FULL_BRANCH_NAME="$ISSUE_ID/$BRANCH_NAME"
    else
        FULL_BRANCH_NAME="$ISSUE_ID"
    fi

    git branch "feature/$FULL_BRANCH_NAME"
    git switch "feature/$FULL_BRANCH_NAME"
}

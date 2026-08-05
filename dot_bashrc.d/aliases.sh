alias la='ls -lhAF --color=auto'
alias j='jobs'

alias man-search='man -k . | fzf --height 40% | awk "{print \$1}" | xargs -r man'

mkcd() {
    mkdir -p -- "$1" && cd -P -- "$1"
}

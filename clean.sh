#!/usr/bin/env bash

msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0' ]; then
    msg "\e[32m[✔]\e[0m ${1}${2}"
    fi
}

function clean_backups() {
    echo 'clean .vim/backup'
    rm -rf  "$HOME/.vim/backup"
    ret="$?"
    success "$1"
}

function clean_views() {
    echo 'clean .vim/view'
    rm -rf  "$HOME/.vim/view"
    ret="$?"
    success "$1"
}

function clean_caches() {
    echo 'clean .vim/cache'
    rm -rf  "$HOME/.vim/cache"
    ret="$?"
    success "$1"
}

function clean_sessions() {
    echo 'clean .vim/session'
    rm -rf  "$HOME/.vim/session"
    ret="$?"
    success "$1"
}

function clean_undos() {
    echo 'clean .vim/undo'
    rm -rf  "$HOME/.vim/undo"
    ret="$?"
    success "$1"
}

function clean_swaps() {
    echo 'clean .vim/swap'
    rm -rf  "$HOME/.vim/swap"
    ret="$?"
    success "$1"
}

function clean_all() {
    echo 'clean all'
    clean_views
    clean_swaps
    clean_undos
    clean_caches
    clean_backups
    clean_sessions
}

case $1 in
    backup )
        clean_backups
        ;;
    cache )
        clean_caches
        ;;
    session )
        clean_sessions
        ;;
    swap )
        clean_swaps
        ;;
    undo )
        clean_undos
        ;;
    view )
        clean_views
        ;;
    all )
        clean_all
        ;;
    *)
        echo 'input: all, backup, cache, session, swap, undo or view'
        ;;
esac

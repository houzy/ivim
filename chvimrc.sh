#!/usr/bin/env bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    app_dir=$(dirname $(greadlink -f $0))
else
    app_dir=$(dirname $(readlink -f $0))
fi

debug_mode='0'
fork_maintainer='0'

msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0' ]; then
    msg "\e[32m[✔]\e[0m ${1}${2}"
    fi
}

error() {
    msg "\e[31m[✘]\e[0m ${1}${2}"
    exit 1
}

debug() {
    if [ "$debug_mode" -eq '1' ] && [ "$ret" -gt '1' ]; then
      msg "An error occurred in function \"${FUNCNAME[$i+1]}\" on line ${BASH_LINENO[$i+1]}, we're sorry for that."
    fi
}

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
    ret="$?"
    debug
}

create_symlinks() {
    echo 'create links'

    endpath="$app_dir"

    if [ $1 = 1 ]; then
        lnif    "$endpath/vimrc"  "$HOME/.vimrc"
        lnif    "$endpath/vimrc.local" "$HOME/.vimrc.local"
        lnif    "$endpath/vimrc.ivim.local" "$HOME/.vimrc.ivim.local"
        lnif    "$endpath/vimrc.bundles.local" "$HOME/.vimrc.bundles.local"
    else
        lnif    "$endpath/vimrc_mini"  "$HOME/.vimrc"
    fi

    lnif    "$endpath/.vim"   "$HOME/.vim"

    # Useful for fork maintainers
    if [ -e "$endpath/gvimrc.local" ]; then
        ln -sf "$endpath/gvimrc.local" "$HOME/.gvimrc.local"
    fi

    ret="$?"
    success "$1"
    debug
}

function clean_symlinks() {
    echo 'clean old links'

    rm -f  "$HOME/.vimrc"
    rm -f  "$HOME/.vimrc.bundles"
    rm -f  "$HOME/.vimrc.before"
    rm -f  "$HOME/.vim"

    rm -f "$HOME/.vimrc.local"
    rm -f "$HOME/.vimrc.ivim.local"
    rm -f "$HOME/.vimrc.before.local"
    rm -f "$HOME/.vimrc.bundles.local"
    rm -f "$HOME/.vimrc.fork"
    rm -f "$HOME/.vimrc.bundles.fork"
    rm -f "$HOME/.vimrc.before.fork"

    rm -f "$HOME/.gvimrc.local"

    ret="$?"
    success "$1"
    debug
}

case $1 in
    vimrc )
        echo 'using vimrc'
        clean_symlinks
        ln -sf "$HOME/vimrc/.vimrc" "$HOME/.vimrc"
        ln -sf "$HOME/vimrc/.vim" "$HOME/.vim"
        ;;
    vundle )
        echo 'using vimrcVundle'
        clean_symlinks
        ln -sf "$HOME/vimrcVundle/.vimrc" "$HOME/.vimrc"
        ln -sf "$HOME/vimrcVundle/.vim" "$HOME/.vim"
        ;;
    ivim )
        echo 'using vimrcivim'
        clean_symlinks
        create_symlinks 1
        ;;
    ivimmini )
        echo 'using vimrcivimmini'
        clean_symlinks
        create_symlinks 0
        ;;
    *)
        echo 'input: vimrc, vundle or ivim'
        ;;
esac

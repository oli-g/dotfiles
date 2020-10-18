#!/bin/bash

if ! formula_exists "zsh" ; then
    e_header "Installing zsh..."
    brew install zsh
else
    ask_confirmation "Updating zsh..."
    if is_confirmed ; then
        ! brew upgrade zsh
    fi
fi

if [[ ! -e "${HOME}/.zshrc" ]] ; then
    touch "${HOME}/.zshrc"
fi

if ! grep --quiet --fixed-strings "/usr/local/bin/zsh" "/private/etc/shells" ; then
    echo "/usr/local/bin/zsh" | sudo tee -a "/private/etc/shells"
fi

if ! is_zsh_shell || is_system_zsh_shell ; then
    sudo chsh -s "/usr/local/bin/zsh" "${USER}"
fi

if ! file_exists "${HOME}/.zim/zimfw.zsh" ; then
    mkdir -p "${HOME}/.zim"
    curl -fsSLo "${HOME}/.zim/zimfw.zsh" "https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh"
fi

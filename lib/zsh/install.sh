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

grep -q -F "/usr/local/bin/zsh" "/private/etc/shells" || echo "/usr/local/bin/zsh" | sudo tee -a "/private/etc/shells"

if ! is_zsh_shell || is_system_zsh_shell ; then
    chsh -s "/usr/local/bin/zsh" $USER
fi

if ! formula_exists "zplug" ; then
    e_header "Installing zplug..."
    brew install zplug
else
    ask_confirmation "Updating zplug..."
    if is_confirmed ; then
        ! brew upgrade zplug
    fi
fi

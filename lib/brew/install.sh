#!/bin/bash

if ! type_exists 'brew'; then
    e_header "Installing brew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    ask_confirmation "Updating brew..."
    if is_confirmed; then
        brew update
    fi
fi
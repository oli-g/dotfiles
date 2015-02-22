#!/bin/bash

if ! formula_exists "vim"; then
    e_header "Installing vim..."
    brew install vim --override-system-vi
else
    ask_confirmation "Updating vim..."
    if is_confirmed; then
        brew upgrade vim
    fi
fi
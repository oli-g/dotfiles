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

if ! formula_exists "cask"; then
    e_header "Installing cack..."
    brew install caskroom/cask/brew-cask
else
    ask_confirmation "Updating cask..."
    if is_confirmed; then
    	brew upgrade brew-cask
    fi
fi
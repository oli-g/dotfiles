#!/bin/bash

if ! type_exists "brew" ; then
    e_header "Installing brew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    ask_confirmation "Updating brew..."
    if is_confirmed ; then
        ! brew doctor
        brew update
    fi
fi

if ! formula_exists "mas" ; then
    e_header "Installing mas..."
    brew install mas
else
    ask_confirmation "Updating mas..."
    if is_confirmed ; then
        ! brew upgrade mas
    fi
fi

if ! tap_exists "homebrew/bundle" ; then
    e_header "Installing bundle tap..."
    brew tap "homebrew/bundle"
fi

if [[ ! -e "${HOME}/.Brewfile.local" ]] ; then
    e_header "Dumping packages and casks into ${HOME}/.Brewfile.local file..."
    brew bundle dump --file="${HOME}/.Brewfile.local"
fi

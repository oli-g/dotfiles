#!/bin/bash

if ! type_exists "brew" ; then
    e_header "Installing brew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    ask_confirmation "Updating brew..."
    if is_confirmed ; then
        brew doctor
        brew update
    fi
fi

if ! tap_exists "caskroom/cask" ; then
    e_header "Installing cask..."
    brew tap "caskroom/cask"
else
    brew cask doctor
fi

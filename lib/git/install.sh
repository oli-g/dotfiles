#!/bin/bash

if ! formula_exists "git" ; then
    e_header "Installing git..."
    brew install git
else
    ask_confirmation "Updating git..."
    if is_confirmed ; then
        ! brew upgrade git
    fi
fi

if ! file_exists "${HOME}/.gitconfig.local" ; then
    e_header "Setting up ${HOME}/.gitconfig.local file..."
    ask "Git author name"
    author_name=$(answer)
    ask "Git author email"
    author_email=$(answer)
    credentials_helper="osxkeychain"
    git config --file "${HOME}/.gitconfig.local" user.name "${author_name}"
    git config --file "${HOME}/.gitconfig.local" user.email "${author_email}"
    git config --file "${HOME}/.gitconfig.local" credential.helper "${credentials_helper}"
fi

git config --global include.path "~/.gitconfig.local"

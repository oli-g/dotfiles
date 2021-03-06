#!/bin/bash

if ! formula_exists "docker"; then
    e_header "Installing docker..."
    brew install docker
else
    ask_confirmation "Updating docker..."
    if is_confirmed; then
        brew upgrade docker
    fi
fi

if ! formula_exists "boot2docker"; then
    e_header "Installing boot2docker..."
    brew install boot2docker
    boot2docker init
else
    ask_confirmation "Updating boot2docker..."
    if is_confirmed; then
        brew upgrade boot2docker
    fi
fi

if ! formula_exists "docker-compose"; then
    e_header "Installing docker-compose..."
    brew install docker-compose
else
    ask_confirmation "Updating docker-compose..."
    if is_confirmed; then
        brew upgrade docker-compose
    fi
fi
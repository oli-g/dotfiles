#!/bin/bash

if ! formula_exists "awscli"; then
    e_header "Installing awscli..."
    brew install awscli
    if ! [ -e "${HOME}/.aws/credentials" ]; then
        e_header "Setting up aws credentials file..."
        aws configure
    fi
else
    ask_confirmation "Updating awscli..."
    if is_confirmed; then
        brew upgrade awscli
    fi
fi
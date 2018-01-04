#!/bin/bash

if ! formula_exists "mysql"; then
    e_header "Installing mysql..."
    brew install mysql
else
    ask_confirmation "Updating mysql..."
    if is_confirmed; then
        brew upgrade mysql
    fi
fi
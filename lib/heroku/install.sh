#!/bin/bash

if ! formula_exists "heroku-toolbelt"; then
    e_header "Installing heroku-toolbelt..."
    brew install heroku-toolbelt
else
    ask_confirmation "Updating heroku-toolbelt..."
    if is_confirmed; then
        brew upgrade heroku-toolbelt
    fi
fi
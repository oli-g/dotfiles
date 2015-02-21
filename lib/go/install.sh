#!/bin/bash

if ! formula_exists "go"; then
    e_header "Installing go..."
    brew install go --with-cc-common
    if ! formula_exists "hg"; then
        e_header "Installing mercurial..."
        brew install hg
    fi
else
    ask_confirmation "Updating go..."
    if is_confirmed; then
        brew upgrade go
    fi
    ask_confirmation "Updating mercurial..."
    if is_confirmed; then
        brew upgrade hg
    fi
fi
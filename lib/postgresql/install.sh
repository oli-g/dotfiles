#!/bin/bash

if ! formula_exists "postgresql"; then
    e_header "Installing postgresql..."
    brew install postgresql

    export PGDATA="/usr/local/var/postgres"
else
    ask_confirmation "Updating postgresql..."
    if is_confirmed; then
        brew upgrade postgresql
    fi
fi
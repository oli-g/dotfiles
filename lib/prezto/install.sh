#!/bin/bash

if [[ ! -d ${PREZTO_PATH} ]]; then
    e_header "Installing prezto..."
    git clone --recursive "${PREZTO_GIT_REMOTE}" "${HOME}/.zprezto"
else
    ask_confirmation "Updating prezto..."
    if is_confirmed; then
        e_header "Bo"
    fi
fi
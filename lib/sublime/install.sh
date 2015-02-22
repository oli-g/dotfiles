#!/bin/bash

SUBLIME_PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin"

if [[ ! -d ${SUBLIME_PATH} ]]; then
    e_warning "Warning: sublime has not been installed yet."
    e_advice "Download it from: http://www.sublimetext.com/3"
else
    if ! type_exists 'subl'; then
        e_header "Installing sublime shell extension..."
        sudo ln -fs "${SUBLIME_PATH}/subl" /usr/bin/subl
    fi
fi
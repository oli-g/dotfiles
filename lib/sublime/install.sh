#!/bin/bash

SUBLIME_PACKAGE_CONTROL_PATH="${HOME}/Library/Application Support/Sublime Text 3/Installed Packages/Package Control.sublime-package"
SUBLIME_PACKAGE_CONTROL_DOWNLOAD_URL="https://packagecontrol.io/Package%20Control.sublime-package"

if [[ ! -e "${SUBLIME_PACKAGE_CONTROL_PATH}" ]]; then
    ask_confirmation "Installing Sublime3 Package Control..."
    if is_confirmed ; then
        curl -fsSLo "${SUBLIME_PACKAGE_CONTROL_PATH}" "${SUBLIME_PACKAGE_CONTROL_DOWNLOAD_URL}"
    fi
fi

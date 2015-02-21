#!/bin/bash

if is_system_zsh_shell; then
    e_header "Installing zsh..."
    brew install zsh
    # Set permission to use zsh installed by brew
    grep -q -F "/usr/local/bin/zsh" /etc/shells || echo "/usr/local/bin/zsh" | sudo tee -a /etc/shells
    chsh -s /usr/local/bin/zsh $USER
    # Fix the OSX zsh environment bug
    if [[ -e /etc/zshenv ]]; then
        sudo mv /etc/{zshenv,zshrc}
    fi
else
    ask_confirmation "Updating zsh..."
    if is_confirmed; then
        brew upgrade zsh
    fi
fi
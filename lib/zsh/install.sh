#!/bin/bash

if ! formula_exists "zsh" ; then
    e_header "Installing zsh..."
    brew install zsh
else
    ask_confirmation "Updating zsh..."
    if is_confirmed ; then
        ! brew upgrade zsh
    fi
fi

if ! grep --quiet --fixed-strings "/usr/local/bin/zsh" "/private/etc/shells" ; then
    echo "/usr/local/bin/zsh" | sudo tee -a "/private/etc/shells"
fi

# Change default shell to zsh
if ! is_zsh_shell || is_system_zsh_shell ; then
    sudo chsh -s "/usr/local/bin/zsh" "${USER}"
fi

# Set up .zshrc.local file into home folder
if ! file_exists "${HOME}/.zshrc.local" ; then
    e_header "Setting up ${HOME}/.zshrc.local file..."
    cp "${DOTFILES_HOME}/lib/zsh/zshrc.local" "${HOME}/.zshrc.local"
fi

# Install zim modules
if [[ -s "${HOME}/.zshrc" ]] ; then
    e_header "Installing zim modules..."
    zsh -c 'source "${HOME}/.zshrc"'

     # Configure powerlevel10k
    if ! file_exists "${HOME}/.p10k.zsh" ; then
        e_header "Configuring powerlevel10k shell theme..."
        zsh -c 'source "${HOME}/.zshrc" && p10k configure'
    fi
fi

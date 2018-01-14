#!/bin/bash

# Update dotfiles repo
# Symlink dotfiles
# Update zplug plugins
run_setup() {
    # Update the dotfiles repository
    if [[ ! -d "${DOTFILES_HOME}/.git" ]] ; then
        e_header "Cloning dotfiles..."
        git clone -b "${DOTFILES_GIT_BRANCH}" "${DOTFILES_GIT_REMOTE}" "${DOTFILES_HOME}"
    else
        ask_confirmation "Updating dotfiles..."
        if is_confirmed ; then
            git -C "${DOTFILES_HOME}" pull --rebase origin "${DOTFILES_GIT_BRANCH}"
        fi
    fi

    # Symlink dotfiles into home folder
    e_header "Symlinking dotfiles..."
    for file in $(find -H "${DOTFILES_HOME}/lib" -maxdepth 2 -name "*.symlink") ; do
        ln -fs $file "${HOME}/.$(basename "${file%.*}")"
    done

    # Setup .zshrc.local file into home folder
    if [[ ! -e "${HOME}/.zshrc.local" ]] ; then
        e_header "Setting up .zshrc.local file..."
        cp "${DOTFILES_HOME}/lib/zshrc.local.example" "${HOME}/.zshrc.local"
    fi

    # Update zplug plugins
    if is_zsh_shell && ! is_system_zsh_shell ; then
        if formula_exists "zplug" ; then
            ask_confirmation "Updating zplug plugins..."
            if is_confirmed ; then
                zsh -c '[[ -s "${ZPLUG_HOME}/init.zsh" ]] && source "${ZPLUG_HOME}/init.zsh"; zplug update'
            fi
        fi
    fi
}

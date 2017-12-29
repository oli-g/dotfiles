#!/bin/bash

run_help() {
    cat <<EOT
OS X dotfiles - Giannicola Olivadoti - http://oli-g.me/
Usage: $(basename "$0") [options]
Options:
    -h, --help      Print this help text
    -l, --list      Print a list of additional software to install
    --no-packages   Suppress package updates
    --no-sync       Suppress pulling from the remote repository
Documentation can be found at https://github.com/oli-g/dotfiles/
Copyright (c) Giannicola Olivadoti
Licensed under the MIT license.
EOT
}

# Install MacOS updates
# Install Xcode tools
# Apply MacOS defaults
# Install brew
# Install git
# Install zsh
# Clone dotfiles repo
run_init() {
    # sudo -v
    # while true ; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

    ## Setup ComputerName and HostName
    # TODO

    # Install MacOS Software
    e_header "Installing MacOS Software Updates..."
    ! softwareupdate --install --all --verbose

    # Install Xcode Command Line Tools
    e_header "Installing Xcode Command Line Tools..."
    ! xcode-select --install

    ## Apply MacOS Defaults for Developers
    # TODO

    # Install brew
    source "${DOTFILES_PATH}/lib/brew/install.sh"

    # Install git
    source "${DOTFILES_PATH}/lib/git/install.sh"

    # Install zsh
    source "${DOTFILES_PATH}/lib/zsh/install.sh"

    # Setup the dotfiles repository, if missing
    if [[ ! -d "${DOTFILES_PATH}/.git" ]] ; then
        e_header "Cloning dotfiles..."
        git clone -b "${DOTFILES_GIT_BRANCH}" "${DOTFILES_GIT_REMOTE}" "${DOTFILES_PATH}"
    fi
}

# Install brew apps (from ~/.Brewfile)
# Install cask apps (from ~/.Brewfile)
# Install AppStore apps (from ~/.Brewfile)
# Install regular apps
# Configure apps
run_bootstrap() {
    # Install brew
    source "${DOTFILES_PATH}/lib/brew/install.sh"

    # Install global brew bundle apps
    ln -fs "${DOTFILES_PATH}/lib/Brewfile" "${HOME}/.Brewfile"
    brew bundle --global

    # Install local brew bundle apps
    if [[ -e "${HOME}/.Brewfile.local" ]] ; then
        brew bundle --file "${HOME}/.Brewfile.local"
    fi

    # Firefox
    # Google Chrome
    # Opera

    # Filezilla
    # iTerm 2
    # ImageAlpha
    # ImageOptim
    # VirtualBox
    # XAMPP

    # Alfred
    # Divvy
    # Dropbox
    # Flux
    # KeePassX
    # LimeChat
    # Network Connect
    # Skype
    # uTorrent
    # VLC

    # source "${DOTFILES_PATH}/lib/brew/install.sh"
    # source "${DOTFILES_PATH}/lib/zsh/install.sh"
    # source "${DOTFILES_PATH}/lib/git/install.sh"
    # source "${DOTFILES_PATH}/lib/sublime/install.sh"
    # source "${DOTFILES_PATH}/lib/vim/install.sh"
    # source "${DOTFILES_PATH}/lib/prezto/install.sh"
    # source "${DOTFILES_PATH}/lib/ruby/install.sh"
    # source "${DOTFILES_PATH}/lib/mysql/install.sh"
    # source "${DOTFILES_PATH}/lib/postgresql/install.sh"
    # source "${DOTFILES_PATH}/lib/go/install.sh"
    # source "${DOTFILES_PATH}/lib/docker/install.sh"
    # source "${DOTFILES_PATH}/lib/aws/install.sh"
    # source "${DOTFILES_PATH}/lib/heroku/install.sh"
}

# Update dotfiles repo
# Symlink dotfiles
# Update zplug plugins
run_setup() {
    # Update the dotfiles repository
    if [[ ! -d "${DOTFILES_PATH}/.git" ]] ; then
        e_header "Cloning dotfiles..."
        git clone -b "${DOTFILES_GIT_BRANCH}" "${DOTFILES_GIT_REMOTE}" "${DOTFILES_PATH}"
    else
        ask_confirmation "Updating dotfiles..."
        if is_confirmed ; then
            git -C "${DOTFILES_PATH}" pull --rebase origin "${DOTFILES_GIT_BRANCH}"
        fi
    fi

    # Symlink dotfiles into home folder
    e_header "Symlinking dotfiles..."
    for file in $(find -H "${DOTFILES_PATH}/lib" -maxdepth 2 -name "*.symlink") ; do
        ln -fs $file "${HOME}/.$(basename "${file%.*}")"
    done

    # Setup .localrc file into home folder
    if [[ ! -e "${HOME}/.localrc" ]] ; then
        e_header "Setting up .localrc file..."
        cp "${DOTFILES_PATH}/lib/localrc.example" "${HOME}/.localrc"
    fi

    # Update zplug plugins
    if is_zsh_shell ; then
        if type_exists "zplug" ; then
            ask_confirmation "Updating zplug plugins..."
            if is_confirmed ; then
                zplug update
            fi
        fi
    fi
}

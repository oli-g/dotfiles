#!/bin/bash

# Pull dotfiles repo
# Symlink dotfiles
# Install brew packages and casks (from ~/.Brewfile)
# Install AppStore apps (from ~/.Brewfile)
# Install other apps
# Configure apps
# Apply MacOS defaults
run_update() {
    # Pull dotfiles repository and install dotfiles
    install_dotfiles

    # Install brew
    source "${DOTFILES_HOME}/lib/brew/install.sh"

    ask_confirmation "Installing packages and apps with brew..."
    if is_confirmed ; then
        ! run_brew_bundle
    fi

    # source "${DOTFILES_HOME}/lib/vim/install.sh"
    # source "${DOTFILES_HOME}/lib/prezto/install.sh"
    # source "${DOTFILES_HOME}/lib/ruby/install.sh"
    # source "${DOTFILES_HOME}/lib/go/install.sh"

    source "${DOTFILES_HOME}/lib/aws/install.sh"
    source "${DOTFILES_HOME}/lib/iterm/install.sh"

    ask_confirmation "Applying MacOS Defaults for Developers..."
    if is_confirmed ; then
        apply_macos_defaults
    fi
}

run_brew_bundle() {
    if ! is_signed_in ; then
        e_warning "Please signin to the App Store..."
        open -a "/Applications/App Store.app"
        until is_signed_in ; do
            sleep 3
        done
    fi

    # Install global brew bundle apps
    ln -fs "${DOTFILES_HOME}/lib/Brewfile" "${HOME}/.Brewfile"
    e_header "Bundling from ${HOME}/.Brewfile..."
    brew bundle --verbose --global

    # Install local brew bundle apps
    if file_exists "${HOME}/.Brewfile.local" ; then
        e_header "Bundling from ${HOME}/.Brewfile.local..."
        brew bundle --verbose --file="${HOME}/.Brewfile.local"
    fi
}

apply_macos_defaults() {
    # Apply MacOS Defaults
    source "${DOTFILES_HOME}/bin/macos_apply_defaults"
}

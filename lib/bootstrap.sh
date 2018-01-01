#!/bin/bash

# Install brew apps (from ~/.Brewfile)
# Install cask apps (from ~/.Brewfile)
# Install AppStore apps (from ~/.Brewfile)
# Install regular apps
# Configure apps
# Apply MacOS defaults
run_bootstrap() {
    # Install brew
    source "${DOTFILES_HOME}/lib/brew/install.sh"

    run_brew_bundle

    # source "${DOTFILES_HOME}/lib/brew/install.sh"
    # source "${DOTFILES_HOME}/lib/zsh/install.sh"
    # source "${DOTFILES_HOME}/lib/git/install.sh"
    # source "${DOTFILES_HOME}/lib/sublime/install.sh"
    # source "${DOTFILES_HOME}/lib/vim/install.sh"
    # source "${DOTFILES_HOME}/lib/prezto/install.sh"
    # source "${DOTFILES_HOME}/lib/ruby/install.sh"
    # source "${DOTFILES_HOME}/lib/mysql/install.sh"
    # source "${DOTFILES_HOME}/lib/postgresql/install.sh"
    # source "${DOTFILES_HOME}/lib/go/install.sh"
    # source "${DOTFILES_HOME}/lib/docker/install.sh"
    # source "${DOTFILES_HOME}/lib/aws/install.sh"
    # source "${DOTFILES_HOME}/lib/heroku/install.sh"

    ## Apply MacOS Defaults for Developers
    # TODO
    apply_macos_defaults
}

run_brew_bundle() {
    # Install global brew bundle apps
    ln -fs "${DOTFILES_HOME}/lib/Brewfile" "${HOME}/.Brewfile"
    brew bundle --global

    # Install local brew bundle apps
    if [[ -e "${HOME}/.Brewfile.local" ]] ; then
        brew bundle --file "${HOME}/.Brewfile.local"
    fi
}

apply_macos_defaults() {
    # TODO
    # https://github.com/mathiasbynens/dotfiles/blob/master/.macos
    # https://github.com/holman/dotfiles/blob/master/macos/set-defaults.sh
    # https://github.com/necolas/dotfiles/blob/master/bin/osxdefaults
    # https://github.com/matijs/dotfiles/blob/master/osx.sh
    # https://github.com/skwp/dotfiles/blob/master/bin/macos
    # https://github.com/donnemartin/dev-setup/blob/master/osx.sh
    # https://github.com/ptb/mac-setup/blob/develop/mac-setup.command#L1525
    # https://github.com/ptb/mac-setup/blob/develop/mac-setup.command#L2668
    # https://github.com/ptb/mac-setup/blob/develop/mac-setup.command#L3159
    # https://github.com/ptb/mac-setup/blob/develop/mac-setup.command#L3291
    # https://github.com/bkuhlmann/mac_os-config/blob/master/bin/apply_default_settings
}

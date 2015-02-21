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
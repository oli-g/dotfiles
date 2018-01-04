#!/bin/bash

if ! formula_exists "go"; then
    e_header "Installing go..."
    brew install go --with-cc-common
    if ! formula_exists "hg"; then
        e_header "Installing mercurial..."
        brew install hg
    fi

    export GOPATH="${PROJECTS_PATH}/go"
    export GOROOT="/usr/local/opt/go/libexec"
    if [[ ! -d "${GOPATH}/bin" ]]; then
        mkdir -p "${GOPATH}/bin"
    fi
    export PATH="${GOPATH}/bin":$PATH:"${GOROOT}/bin"

    e_header "Installing godoc..."
    go get golang.org/x/tools/cmd/godoc
    e_header "Installing vet..."
    go get golang.org/x/tools/cmd/vet
    e_header "Installing godep"
    go get github.com/tools/godep
else
    ask_confirmation "Updating go..."
    if is_confirmed; then
        brew upgrade go
    fi
    ask_confirmation "Updating mercurial..."
    if is_confirmed; then
        brew upgrade hg
    fi
fi
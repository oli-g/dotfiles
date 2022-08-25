#!/bin/bash

if ! file_exists "${HOME}/.aws/credentials" ; then
    if formula_exists "awscli" ; then
        e_header "Setting up ${HOME}/.aws/credentials file..."
        ! aws configure
    fi
fi

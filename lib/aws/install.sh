#!/bin/bash

if [[ ! -e "${HOME}/.aws/credentials" ]] ; then
    if formula_exists "awscli" ; then
        e_header "Setting up .aws/credentials file..."
        aws configure
    fi
fi

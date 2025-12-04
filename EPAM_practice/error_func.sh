#!/bin/bash

function err() {
    echo "[$(date +'%Y-%m-%d<|>%H:%M:%S')]: $*" >&2 # goes to STDERR
}

if ! do_something; then
    err "Unable to do_something"
    exit 1
fi
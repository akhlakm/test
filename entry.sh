#!/bin/bash

function exit_script() {
    echo "Caught SIGTERM"
    exit 0
}

# Catch docker stop signal.
trap exit_script SIGTERM SIGINT SIGQUIT

export PATH=$PATH:/home/apps/.local/bin

if [[ "$#" -lt 1 ]]; then
    echo -e "User webserver at $WEBSERVER_HOST_PORT"

    if [[ -d /data ]]; then
        echo "Found mounted volume /data"
        export PIP_CACHE_DIR=/data/pip_cache
    fi

    tail -f /dev/null   # do not exit

else
    # If arguments (e.g. install, run, create) are given, execute them.
    # These can be run by logging into the running container terminal.
    "$@"
fi

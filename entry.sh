#!/bin/bash

# Catch docker stop signal.
function exit_script() {
    echo "Caught SIGTERM"
    exit 0
}
trap exit_script SIGTERM SIGINT SIGQUIT

export PATH=$PATH:/home/apps/.local/bin:/opt/conda/bin
export CONDAVENV=/home/apps/condaenv
eval "$(command conda 'shell.bash' 'hook' 2> /dev/null)"

if [[ -d /data ]]; then
    echo "Found mounted volume /data"
    export PIP_CACHE_DIR=/data/pip_cache
    export CONDAVENV=/data/condaenv
fi

if ! conda activate venv; then
     conda create -y --prefix $CONDAVENV python numpy -c conda-forge
     conda activate $CONDAVENV
fi

if [[ "$#" -lt 1 ]]; then
    pip -v install -r requirements.txt

    echo -e "Exposed container port: $WS_PORT"
    tail -f /dev/null   # do not exit

else
    # If arguments (e.g. install, run, create) are given, execute them.
    # These can be run by logging into the running container terminal.
    "$@"
fi

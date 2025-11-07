#! /bin/bash

set -euo pipefail

# set -x # Debug

SCRIPT_FOLDER="$(realpath "$(dirname "$0")")"

EXEC_FILE_NAME="launch_local_module.sh"

EXEC_PATH="$(realpath "$SCRIPT_FOLDER/../scripts/$EXEC_FILE_NAME")"

SYSTEMD_UNITS_FOLDER="/etc/systemd/system"

LOCAL_MODULE_FILE_NAME="local_module.service"


LOCAL_MODULE_DST="$SYSTEMD_UNITS_FOLDER/$LOCAL_MODULE_FILE_NAME"

service_text="[Unit]
Description=Weeder module in local execution
[Service]
User=earth
Group=earth
ExecStart=$EXEC_PATH"

if [ ! -e "$LOCAL_MODULE_DST" ] ; then
    echo -e "$service_text" | sudo tee "$LOCAL_MODULE_DST" > /dev/null
fi

sudo systemctl daemon-reload

sudo systemctl enable "$LOCAL_MODULE_FILE_NAME"

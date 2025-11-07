#! /bin/bash

set -euo pipefail

# set -x # Debug

SCRIPT_FOLDER="$(realpath "$(dirname "$0")")"

EXEC_FILE_NAME="service_trampoline_server.py"

INFRA_REPO_PATH="$(rospack find earth_rover_robot_ui_infra)"

EXEC_PATH="$(realpath "$INFRA_REPO_PATH/src/$EXEC_FILE_NAME")"

SYSTEMD_UNITS_FOLDER="/etc/systemd/system"

TRAMPOLINE_SERVICE_FILE_NAME="camera_calibration.service"

TRAMPOLINE_SERVICE_DST="$SYSTEMD_UNITS_FOLDER/$TRAMPOLINE_SERVICE_FILE_NAME"

service_text="[Unit]
Description=Service trampoline server
After=network.target
[Service]
ExecStart=$EXEC_PATH --allowed-service-prefix-list weederstart camera_calibration
Restart=on-abort
[Install]
WantedBy=multi-user.target"

if [ ! -e "$TRAMPOLINE_SERVICE_DST" ] ; then
    echo -e "$service_text" | sudo tee "$TRAMPOLINE_SERVICE_DST" > /dev/null
fi

sudo systemctl daemon-reload

sudo systemctl enable "$TRAMPOLINE_SERVICE_FILE_NAME"
sudo systemctl start  "$TRAMPOLINE_SERVICE_FILE_NAME"

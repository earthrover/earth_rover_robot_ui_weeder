#! /bin/bash

set -euo pipefail

# set -x # Debug

SCRIPT_FOLDER="$(realpath "$(dirname "$0")")"

EXEC_FILE_NAME="launch_camera_calibration.sh"

EXEC_PATH="$(realpath "$SCRIPT_FOLDER/../scripts/$EXEC_FILE_NAME")"

SYSTEMD_UNITS_FOLDER="/etc/systemd/system"

CALIBRATION_SERVICE_FILE_NAME="camera_calibration.service"


CALIBRATION_SERVICE_DST="$SYSTEMD_UNITS_FOLDER/$CALIBRATION_SERVICE_FILE_NAME"

service_text="[Unit]
Description=Weeder camera calibration
[Service]
User=earth
Group=earth
ExecStart=$EXEC_PATH"

if [ ! -e "$CALIBRATION_SERVICE_DST" ] ; then
    echo -e "$service_text" | sudo tee "$CALIBRATION_SERVICE_DST" > /dev/null
fi

sudo systemctl daemon-reload

sudo systemctl enable "$CALIBRATION_SERVICE_FILE_NAME"

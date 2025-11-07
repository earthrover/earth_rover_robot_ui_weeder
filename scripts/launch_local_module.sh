#! /bin/bash

export ROS_LOG_DIR="/home/earth/data/log"
export ROSCONSOLE_FORMAT="[${severity}] [${time}] [${node}]: ${message}"
export DARKNET_PATH="/home/earth/libs/earth_rover_darknet"
export PATH="/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
export LD_LIBRARY_PATH="/usr/local/cuda/targets/aarch64-linux/lib:/usr/local/lib"
export CPATH="/usr/local/cuda/targets/aarch64-linux/include:"

source /home/earth/earth_rover_ws/devel/setup.bash

echo '<launch>
    <include file="$(find earth_rover_robot_ui_infra)/launch/web_bridge.launch"/>
    <include file="$(find earth_rover_weeder_robot)/launch/weeder_module.launch"/>
</launch>' | stdbuf -oL -eL roslaunch --screen -

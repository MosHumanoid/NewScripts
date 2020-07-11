#!/bin/sh

cd ~/
mkdir -p bitbots/src
mkdir -p seconds/src
ROS_WORKSPACE="$HOME/bitbots"
ROS_SECONDARY_WORKSPACE="$HOME/seconds"
echo "ROS WORKSPACE at:	        \033[91m\033[1m${ROS_WORKSPACE}\033[0m"
echo "ROS Secondary workspace at:	\033[91m\033[1m${ROS_SECONDARY_WORKSPACE}\033[0m"

cd bitbots/src
{
    git clone https://github.com/MosHumanoid/bitbots_meta.git
    cd bitbots_meta
    git submodule init
    git submodule update
}
if [! -d "${ROS_SECONDARY_WORKSPACE}/src/geometry2" ]; then 
    mv ~/bitbots/src/bitbots_meta/lib/vision_opencv ~/seconds/src/.
else
    read -p "Already exist vision_opencv package in ROS_SECONDARY_WORKSPACE"
fi
if [ -d "${ROS_WORKSPACE}/src/bitbots_meta/lib/geometry2" ]; then
    mv ~/bitbots/src/bitbots_meta/lib/geometry2 ~/seconds/src/.
elif [ ! -d "${ROS_SECONDARY_WORKSPACE}/src/geometry2" ]; then
    read -p "There is no geometry2 in bitbots_meta.Clone a geometry2 package "
    cd ${ROS_SECONDARY_WORKSPACE}/src/.
    git clone https://github.com/ros/geometry2.git
else
    read -p "Already exist geometry2 package in ROS_SECONDARY_WORKSPACE"
fi


cd ${ROS_WORKSPACE} && catkin build

cd ${ROS_SECONDARY_WORKSPACE} && catkin config -DPYTHON_EXECUTABLE=/usr/bin/python3 -DPYTHON_INCLUDE_DIR=/usr/include/python3.6m -DPYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython3.6m.so && catkin config --install && catkin build

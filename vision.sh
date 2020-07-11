#！/bin/bash

source ~/Documents/bitbots/devel/setup.bash
source ~/second/devel/setup.bash --extend
roslaunch bitbots_vision vision_startup.launch sim:=true;

#!/bin/bash

# Change these variables according to your setup
MONITOR_NUMBER=1  # Replace with your desired monitor number
GAME_COMMAND="your_game_command"  # Replace with the command to launch your game

# Focus on the specified monitor
hyprctl setmonitor $MONITOR_NUMBER focus

# Launch the game
$GAME_COMMAND

# Restore focus to all monitors (or unfocus the specific one)
hyprctl setmonitor $MONITOR_NUMBER unfocus

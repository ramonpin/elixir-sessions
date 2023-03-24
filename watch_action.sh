#!/usr/bin/env zsh

# Launch mix to run tests
clear
unbuffer mix test |& tee /dev/shm/watch_action.txt

if [[ ${pipestatus[1]} -eq 0 ]]; then
  ICON=info
else
  ICON=error
fi

# Grab last three lines and generate a notification
LAST_LINES=$(tail -4 /dev/shm/watch_action.txt | sed -e "s/\x1b\[.\{1,5\}m//g")
notify-send -i $ICON -t 10000 "mix test" "$LAST_LINES"


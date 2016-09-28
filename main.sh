#!/bin/bash

# exit immediately if Preview or QuickTime are already open
if pgrep "Preview" > /dev/null || pgrep "QuickTime" > /dev/null
then
  exit
fi

contents=(./content_button/*)
prompts=(./content_waiting/*)
selected_content="${contents[RANDOM % ${#contents[@]}]}"
selected_prompt="${prompts[RANDOM % ${#prompts[@]}]}"

if [[ "$selected_content" =~ (jpg|JPG|JPEG|png|PNG)$ ]]
then
  # open image with preview, go full screen, wait 5 seconds, quit preview
  open -a Preview "$selected_content" ; /usr/bin/osascript -e 'tell application "Preview"
    activate
    tell application "System Events"
      keystroke "f" using {control down, command down}
    end tell
    delay 5
    quit
  end tell'
else
  # open video with QuickTime, go full screen, play it, quit QuickTime when finished
  open -a QuickTime\ Player "$selected_content" ; /usr/bin/osascript -e 'tell application "QuickTime Player"
    delay 1
    activate
    tell application "System Events"
      keystroke "f" using {control down, command down}
    end tell
    tell document 1
      present
      play
      repeat until playing is false
        delay 1
      end repeat
    end tell
    quit
  end tell'
fi

# open playlist in VLC
open -a VLC ./content_waiting_playlist.m3u

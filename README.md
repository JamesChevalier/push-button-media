# Push Button Media

This lets you press an Amazon IoT Button to play/display a random video/image.
After that finishes, it loops through a collection of other videos.

The idea is that you have a collection of short 'prompt' videos, which are suggesting to the viewer to press the button.
When the button is pressed, the 'prompt' video is closed and a random video/image is selected from a different collection.

This project was built for [The Legible Bodies](https://www.legiblebodies.com/) to use for [their closing reception](https://www.facebook.com/events/655704171259010/) in the [Mill Arts Project](http://www.easthamptoncityarts.com/map) space.

# Requirements

- Amazon IoT Button
  - https://aws.amazon.com/iot/button/
- VLC
  - http://www.videolan.org/vlc/index.html
- Preview
  - It should already be installed on your Mac
- QuickTime
  - It should already be installed on your Mac
- node
  - https://nodejs.org/en/
- ngrok
  - https://ngrok.com/

# Setup

- add videos to `content_waiting`
  - these will play in a random loop while we wait for someone to press the button
- add videos/images to `content_button`
  - this is the content that will be used when someone presses the button
  - any video that is playable by QuickTime and jpg/png files will work
- edit `content_waiting_playlist.m3u` to be a playlist of the `content_waiting` videos
  - you can gather all the `content_waiting` videos in VLC and choose 'Save Playlist...'
- set up your Amazon IoT Button
  - https://aws.amazon.com/iot/button/
  - this process should involve creating a Amazon Lambda function named AWSIoTButton
- `cd endpoint && npm install`
- configure VLC to default to fullscreen with as little UI as possible and play infinitely
  - choose 'Repeat All' in the 'Playback' menu
  - choose 'Random' in the 'Playback' menu
  - open Preferences
    - select 'Interface' and un-check the box for 'Show Fullscreen Controller'
    - select 'Video' and check the box for 'Fullscreen'
    - select 'Subtitles / OSD' and un-check the box for 'Enable OSD'

# Run

- start the endpoint in one terminal: `cd endpoint; node index.js`
- start ngrok in another terminal: `ngrok http 3000`
- edit the `endpointUrl` variable in `button/index.js` to your `http` ngrok url
- copy the code in `button/index.js` to your AWSIoTButton Amazon Lambda function
- push the Amazon IoT Button to display media
  - the transition could be chunky the first time that VLC is run, but subsequent runs should be ok

# What's Happening

- the button triggers the Amazon Lambda function
- the Amazon Lambda function makes a call to the node endpoint via the ngrok url
- the node endpoint checks if Preview or QuickTime is running
  - if Preview or QuickTime is running
    - it does nothing and exits immediately because something is already playing/being shown
  - if Preview or QuickTime is not running
    - it runs the `main.sh` script
      - this plays a video or shows an image for 5 seconds
      - then it quits QuickTime/Preview
      - and finally it plays the infinite playlist in VLC

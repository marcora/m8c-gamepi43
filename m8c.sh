#!/bin/bash

# disable DPMS (Energy Star) features.
xset -dpms

# disable screen saver
xset s off

# don't blank the video device
xset s noblank

# run window manager
matchbox-window-manager -use_cursor no -use_titlebar no  &

# setup audio
export JACK_NO_AUDIO_RESERVATION=1
jackd -d alsa -d hw:M8 -r 44100 -p 512 &
sleep 1

# setup output
alsa_out -j m8out -d hw:0 -r 44100 &
sleep 1

jack_connect system:capture_1 m8out:playback_1
jack_connect system:capture_2 m8out:playback_2

# run m8c
m8c

# shutdown
sudo shutdown now

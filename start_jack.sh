#!/usr/bin/bash

# This will give a latency of 32ms
jackd -R -P 70 -d alsa -C hw:0,0 -P hw:1,0 -r 48000 -p 512 -n 3 &
sleep 3

jack_connect system:capture_1 system:playback_1
jack_connect system:capture_2 system:playback_2

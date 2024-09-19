#!/usr/bin/bash

jackd -R -P 70 -d alsa -C hw:1,0 -P hw:0,0 -r 48000 -p 64 -n 2 &
sleep 3

jack_connect system:capture_1 system:playback_1
jack_connect system:capture_2 system:playback_2

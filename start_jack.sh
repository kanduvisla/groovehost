#!/usr/bin/bash

echo "Killing Jack"
killall jackd
sleep 3

TARGET_RECORD_DEVICE="hw:CARD=ModelCycles,DEV=0"
TARGET_PLAYBACK_DEVICE="hw:CARD=SH4d,DEV=0"

check_record_device() {
    arecord -L | grep -q "$TARGET_RECORD_DEVICE"
}

check_playback_device() {
    aplay -L | grep -q "$TARGET_PLAYBACK_DEVICE"
}

while ! check_record_device; do
    echo "Waiting for device $TARGET_RECORD_DEVICE to become available..."
    sleep 1
done

while ! check_playback_device; do
    echo "Waiting for device $TARGET_PLAYBACK_DEVICE to become available..."
    sleep 1
done

# This will give a latency of 32ms
jackd -v -R -P 99 -d alsa -C "$TARGET_RECORD_DEVICE" -P "$TARGET_PLAYBACK_DEVICE" -r 48000 -p 1024 -n 3 &
#jackd -r -d alsa -C "$TARGET_RECORD_DEVICE" -P "$TARGET_PLAYBACK_DEVICE" -r 48000 -p 1024 -n 2 &
sleep 3

jack_connect system:capture_1 system:playback_1
jack_connect system:capture_2 system:playback_2

# Forward MIDI
echo "Forwarding Midi with a slight delay to account for Jack latency"
python midi_forwarding.py

# Stop the jackd process
echo "Killing Jack"
killall jackd

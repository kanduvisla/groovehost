#!/bin/bash

INPUT_PORT="$1"
OUTPUT_PORT="$2"
DELAY="$3"

# Validate input
if [ -z "$INPUT_PORT" ] || [ -z "$OUTPUT_PORT" ] || [ -z "$DELAY" ]; then
    echo "Usage: $0 <input_port> <output_port> <delay_in_seconds>"
    exit 1
fi

# Run amidi to read from input port and forward to output port with delay
amidi -p "$INPUT_PORT" -d | while IFS= read -r -n2 byte; do
    echo "$byte"
    amidi -p "$OUTPUT_PORT" -S "$byte"
    sleep "$DELAY"
done


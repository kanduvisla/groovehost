import time
import rtmidi
import threading
from queue import Queue

# Set up MIDI input and output
midi_in = rtmidi.MidiIn()
midi_out = rtmidi.MidiOut()

# Replace with your actual MIDI port names or indices
input_port = 1
output_port = 2

midi_in.ignore_types(sysex=True, timing=False, active_sense=True)

midi_in.open_port(input_port)
midi_out.open_port(output_port)

# Set the desired delay in seconds
DELAY = 0.5

# Queue to hold the MIDI messages
midi_queue = Queue()

def midi_callback(message, data=None):
    # print(".")
    #message, deltatime = event
    #print(f"Received message: {message}, deltatime: {deltatime}")
    # Put the incoming MIDI message into the queue with a timestamp
    midi_queue.put((time.time(), message))

midi_in.set_callback(midi_callback)

def process_midi():
    while True:
        if not midi_queue.empty():
            timestamp, message = midi_queue.get()
            current_time = time.time()
            delay_time = timestamp + DELAY

            # Wait until the delay time has passed
            while current_time < delay_time:
                time.sleep(0.001)
                current_time = time.time()

            byte, deltatime = message
            #print(f"Sending byte: {byte}")
            # Send the MIDI message
            midi_out.send_message(byte)

# Start the MIDI processing thread
midi_thread = threading.Thread(target=process_midi)
midi_thread.start()

try:
    while True:
        time.sleep(1)
except KeyboardInterrupt:
    pass

midi_in.close_port()
midi_out.close_port()

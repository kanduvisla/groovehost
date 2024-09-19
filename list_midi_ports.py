import rtmidi

def list_midi_ports():
    midi_in = rtmidi.MidiIn()
    midi_out = rtmidi.MidiOut()

    input_ports = midi_in.get_ports()
    output_ports = midi_out.get_ports()

    print("Available MIDI Input Ports:")
    for i, port in enumerate(input_ports):
        print(f"{i}: {port}")

    print("\nAvailable MIDI Output Ports:")
    for i, port in enumerate(output_ports):
        print(f"{i}: {port}")

list_midi_ports()

import jack
import time

def start_jackd():
    client = jack.Client('groovehost_client')
#    client.activate()

def connect_jack_ports(client):
    # Get a list of input and output ports
    capture_ports = client.get_ports(is_physical=True, is_audio=True, is_input=True)
    playback_ports = client.get_ports(is_physical=True, is_audio=True, is_output=True)

    if len(capture_ports) >= 2 and len(playback_ports) >= 2:
        # Connect the ports
        client.connect(capture_ports[0], playback_ports[0])
        client.connect(capture_ports[1], playback_ports[1])
    else:
        print("Not enough ports available for connection")
        sleep(1)

if __name__ == "__main__":
    client = start_jackd()
    # connect_jack_ports(client)

#!/usr/bin/env python3
# NeoPixel library strandtest example
# Author: Tony DiCola (tony@tonydicola.com)
#
# Direct port of the Arduino NeoPixel library strandtest example.  Showcases
# various animations on a pixels of NeoPixels.

import time
import neopixel
import board
import argparse

# LED pixels configuration:
num_pixels = 350
pixel_pin = board.D12
ORDER = neopixel.RGB

def layers(pixels, color, wait_ms=25, iterations=10):
    """Movie theater light style chaser animation."""
    for j in range(iterations):
        for q in range(3):
            for i in range(0, num_pixels, 3):
                pixels[i+q] = (0, 255, 0)
                pixels.show()
            #time.sleep(wait_ms/1000.0)
            for i in range(0, num_pixels, 3):
                pixels[i+q] = (0, 100, 50)
                pixels.show()

# Main program logic follows:
if __name__ == '__main__':
    # Process arguments
    parser = argparse.ArgumentParser()
    parser.add_argument('-c', '--clear', action='store_true', help='clear the display on exit')
    args = parser.parse_args()

    # Create NeoPixel object with appropriate configuration.
    pixels = neopixel.NeoPixel(
        pixel_pin, num_pixels, brightness=0.2, auto_write=False, pixel_order=ORDER
    )
    
    print ('Press Ctrl-C to quit.')
    if not args.clear:
        print('Use "-c" argument to clear LEDs on exit')

    try:

        while True:
           
            #colorWipe(pixels, Color(0, 255, 0))  # Blue wipe
            layers(pixels, (0, 255, 0))
           
    except KeyboardInterrupt:
        if args.clear:
            colorWipe(pixels, (0,0,0), 10)

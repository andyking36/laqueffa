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
num_pixels = 50
pixel_pin = board.D12
ORDER = neopixel.RGB

# Define functions which animate LEDs in various ways.
def colorWipe(pixels, color, wait_ms=0):
    """Wipe color across display a pixel at a time."""
    for i in range(num_pixels >> 1):
        j = i*2
        pixels[j] = color
        pixels.show()
        time.sleep(wait_ms/(1000.0))  #modified from 1000

def colorWipe1(pixels, color, wait_ms=0):
    """Wipe color across display a pixel at a time."""
    for i in range(num_pixels >> 1):
        j = i*2+1
        pixels[num_pixels-j] = color
        pixels.show()
        time.sleep(wait_ms/(1000.0))  #modified from 1000 

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
           
            for x in range(16):
                colorWipe(pixels, (x * 13 + 44, 0,  (255 - x * 13)))
                colorWipe1(pixels,(x * 13 + 44, 0,  (255 - x * 13)))
            for x in range(16):
                colorWipe(pixels, ((255 - x * 13), 0, x * 13 + 44))
                colorWipe1(pixels, ((255 - x * 13), 0, x * 13 + 44))
              
    except KeyboardInterrupt:
        if args.clear:
            pixels.fill((0, 0, 0))

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



# Define functions which animate LEDs in various ways.
def colorWipe(pixels, color, wait_ms=200):
    """Wipe color across display a pixel at a time."""
    for i in range((num_pixels >> 1)):
        pixels[i] = color
    pixels.show()
    time.sleep(wait_ms/(1000.0))  #modified from 1000
    
    for i in range((num_pixels >> 1)):
        pixels[i+(num_pixels >> 1)] = color
    pixels.show()
    time.sleep(wait_ms/(1000.0))  #modified from 1000
    
    for i in range(num_pixels):
        pixels[i] = (0, 0, 0)
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
           
            colorWipe(pixels, (0, 255, 0))  # Blue wipe
            colorWipe(pixels, (0, 200, 100))  # Blue wipe
            colorWipe(pixels, (100, 200, 0))  # Blue wipe

    except KeyboardInterrupt:
        if args.clear:
            colorWipe(pixels, (0,0,0), 10)

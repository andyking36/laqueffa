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
def colorWipe(pixels, color, wait_ms=10):
    """Wipe color across display a pixel at a time."""
    for i in range(num_pixels):
        pixels[i] = color
        pixels.show()
        time.sleep(wait_ms/(100.0 * (i+1)))  #modified from 1000

def wheel(pos):
    """Generate rainbow colors across 0-255 positions."""
    if pos < 85:
        return (pos * 3, 255 - pos * 3, 0)
    elif pos < 170:
        pos -= 85
        return (255 - pos * 3, 0, pos * 3)
    else:
        pos -= 170
        return (0, pos * 3, 255 - pos * 3)

def rainbow(pixels, wait_ms=20, iterations=1000):
    """Draw rainbow that fades across all pixels at once."""
    for j in range(256*iterations):
        for i in range(num_pixels):
            pixels[i] = wheel((i+j) & 255)
        pixels.show()
        time.sleep(wait_ms/1000.0)

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
            print ('default settings.')
            rainbow(pixels)
    except KeyboardInterrupt:
        if args.clear:
            colorWipe(pixels, Color(0,0,0), 10)

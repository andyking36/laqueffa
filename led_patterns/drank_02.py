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
def colorWipe(pixels, color, wait_ms=25):
    """Wipe color across display a pixel at a time."""
    
    for i in range(50):
        pixels[i] = color
    pixels.show()
    time.sleep(wait_ms/1000.0)

    for i in range(75):
        pixels[i +75] = color
    pixels.show()
    time.sleep(wait_ms/1000.0)

    for i in range(75):
        pixels[i + 150] = color
    pixels.show()
    time.sleep(wait_ms/1000.0)

    for i in range(75):
        pixels[i + 225] = color
    pixels.show()
    time.sleep(wait_ms/1000.0)

    #for i in range(75):
    #    pixels[i + 300] = color
    #pixels.show()
    #time.sleep(wait_ms/1000.0)
       #for i in range(375):
    #    pixels.setPixelColor(i , Color(0, 0, 0))
    #pixels.show()
    #time.sleep(wait_ms/1000.0)


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
            colorWipe(pixels, (0, 200, 55))
            colorWipe(pixels, (0, 50, 200))
            colorWipe(pixels, (0, 0, 255))
            colorWipe(pixels, (0, 50, 200))
            colorWipe(pixels, (0, 200, 55))
            colorWipe(pixels, (0, 255, 0))
            colorWipe(pixels, (55, 200, 0))
            colorWipe(pixels, (200, 50, 0))
            colorWipe(pixels, (255, 0, 0))
            colorWipe(pixels, (200, 50, 0))
            colorWipe(pixels, (55, 200, 0))
            #colorWipe(pixels, Color(55, 200, 0))


            #colorWipe(pixels, Color(255, 50,0))


            #layers(pixels, Color(0, 255, 0))
           
    except KeyboardInterrupt:
        if args.clear:
            colorWipe(pixels, (0,0,0), 10)

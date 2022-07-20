#pins for lights
echo 2 > /sys/class/gpio/export 
echo 3 > /sys/class/gpio/export 
echo 4 > /sys/class/gpio/export

echo out > /sys/class/gpio/gpio2/direction
echo out > /sys/class/gpio/gpio3/direction
echo out > /sys/class/gpio/gpio4/direction

echo 0 > /sys/class/gpio/gpio2/value
echo 0 > /sys/class/gpio/gpio3/value
echo 0 > /sys/class/gpio/gpio4/value

#pins for drink dispenser
echo 5 > /sys/class/gpio/export 
echo 6 > /sys/class/gpio/export 
echo 13 > /sys/class/gpio/export 
echo 19 > /sys/class/gpio/export 
echo 26 > /sys/class/gpio/export

echo out > /sys/class/gpio/gpio5/direction
echo out > /sys/class/gpio/gpio6/direction
echo out > /sys/class/gpio/gpio13/direction
echo out > /sys/class/gpio/gpio19/direction
echo out > /sys/class/gpio/gpio26/direction

echo 1 > /sys/class/gpio/gpio5/value
echo 1 > /sys/class/gpio/gpio6/value
echo 1 > /sys/class/gpio/gpio13/value
echo 1 > /sys/class/gpio/gpio19/value
echo 1 > /sys/class/gpio/gpio26/value

#old pussy button inputs (BM 2019)
echo 17 > /sys/class/gpio/export 

echo in > /sys/class/gpio/gpio17/direction

#new pussy button inputs for drink selections
echo 12 > /sys/class/gpio/export 
echo 16 > /sys/class/gpio/export 
echo 20 > /sys/class/gpio/export 
echo 21 > /sys/class/gpio/export 

echo in > /sys/class/gpio/gpio12/direction
echo in > /sys/class/gpio/gpio16/direction
echo in > /sys/class/gpio/gpio20/direction
echo in > /sys/class/gpio/gpio21/direction

#new rear button inputs for drink selections
echo 14 > /sys/class/gpio/export 
echo 15 > /sys/class/gpio/export 
echo 18 > /sys/class/gpio/export 
echo 23 > /sys/class/gpio/export 

echo in > /sys/class/gpio/gpio14/direction
echo in > /sys/class/gpio/gpio15/direction
echo in > /sys/class/gpio/gpio18/direction
echo in > /sys/class/gpio/gpio23/direction

#remote control inputs from Arduino
echo 24 > /sys/class/gpio/export 
echo 25 > /sys/class/gpio/export 
echo 8 > /sys/class/gpio/export 
echo 7 > /sys/class/gpio/export 

echo in > /sys/class/gpio/gpio24/direction
echo in > /sys/class/gpio/gpio25/direction
echo in > /sys/class/gpio/gpio8/direction
echo in > /sys/class/gpio/gpio7/direction

#bypass switch stops laqueefa button inputs to poor drink
echo 27 > /sys/class/gpio/export 

echo in > /sys/class/gpio/gpio27/direction

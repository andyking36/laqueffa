#!/bin/bash

echo 2 > /sys/class/gpio/export 
echo 3 > /sys/class/gpio/export 
echo 4 > /sys/class/gpio/export 
echo in > /sys/class/gpio/gpio2/direction
echo in > /sys/class/gpio/gpio3/direction
echo in > /sys/class/gpio/gpio4/direction

PYTHONSCRIPTDIR=/home/laqueefa/led_patterns 

sudo PYTHONPATH=".:build/lib.linux-armv71-2.7" python $PYTHONSCRIPTDIR/default_lights.py & 

while [ true ] 
do 
	if [ $(gpio -g read 2) = 1 ] 
	then
		random_num=$((1 + RANDOM % 4))
		echo "You found the clit. Nice work!"
		sudo pkill python
		case $random_num in
			1)
				script=drank_00.py;;
			2)
				script=drank_01.py;;
			3)
				script=drank_02.py;;
			4)
				script=drank_03.py;;
		esac
		sudo PYTHONPATH=".:build/lib.linux-armv71-2.7" python $PYTHONSCRIPTDIR/$script & 
        	sleep 10
		sudo pkill python
		sudo PYTHONPATH=".:build/lib.linux-armv71-2.7" python $PYTHONSCRIPTDIR/default_lights.py & 
	fi

	if [ $(gpio -g read 3) = 1 ]
	then	
		echo "squirt time"
		sudo pkill python
		script=squirt.py
		sudo PYTHONPATH=".:build/lib.linux-armv71-2.7" python $PYTHONSCRIPTDIR/$script & 
        	sleep 2
		sudo pkill python
		script=blink_red.py
		sudo PYTHONPATH=".:build/lib.linux-armv71-2.7" python $PYTHONSCRIPTDIR/$script & 
        	sleep 3
		sudo pkill python
		script=sections.py
		sudo PYTHONPATH=".:build/lib.linux-armv71-2.7" python $PYTHONSCRIPTDIR/$script & 
        	sleep 5
		sudo pkill python
		
		sudo PYTHONPATH=".:build/lib.linux-armv71-2.7" python $PYTHONSCRIPTDIR/default_lights.py & 
	
	fi
done

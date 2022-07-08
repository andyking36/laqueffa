#!/bin/bash
while [ true ]
do 
	
	if [ $(gpio -g read 2) = 1 ]
	then
	       echo "gpio 2 is high"
	       sleep 1
	       date

        fi
	if [ $(gpio -g read 3) = 1 ]
	then
	       echo "gpio 3 is high"
	       sleep 1
	       date

        fi
done	


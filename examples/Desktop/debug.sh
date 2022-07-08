#!/bin/bash
while [ true ]
do 
	
	if [ $(gpio -g read 17) = 0 ]
	then
	       echo "yup, switch is pressed"
	       sleep 0.2
	       echo -s "$date"
	       date 

        fi
done	


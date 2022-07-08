#!/bin/bash

while [ true ]
do
	x=$((1 + RANDOM % 13))
	echo -e "random number is $x"
	sleep 1
done

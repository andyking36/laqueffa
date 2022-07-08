#!/bin/bash
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

#pin for switches
echo 17 > /sys/class/gpio/export 

echo in > /sys/class/gpio/gpio17/direction

################################################



let randomnumber 

while [ true ] 
do 
	if [ $(gpio -g read 17) = 0 ] 
	then
		echo -e "\nbutton pressed\n"
		#sudo pkill -f default_lights.py	
		# DRINK DISPENSER CONTROLLER
   		# "bcm" controls the relay
		# "play" controls the other Pi's LEDs
		randomnumber=$((1 + RANDOM % 13))
		echo -e "RANDOM NUMBER IS  $randomnumber\n"
		case $randomnumber in
			1)
				bcm=5
			        play=2;;
			2)
				bcm=5 
				play=2;;
			3)
				bcm=5 
				play=2;;
			4)
				bcm=5 
				play=2;;
			5)
				bcm=6
				play=2;;
			6)
				bcm=6
				play=2;;
			7)
				bcm=6
				play=2;;
			8)
				bcm=6
			        play=2;;
			9)
				bcm=13 
				play=2;;
			10)
				bcm=13 
				play=2;;
			11)
				bcm=13 
				play=2;;
			12)
				bcm=13
				play=2;;
			13)
				bcm=19
				play=3;;

		esac

		if [ $bcm = 19 ]
		then
			sleep 1
			#mplayer /home/pi/Desktop/Sounds_of_La_Queefa/sad.trombone.mp3 & 
		else		
			# AUDIO PLAYER CONTROLLER
			randomnumber=$((1 + RANDOM % 13))
			echo -e "\nRECORDING NUMBER IS $randomnumber\n"
			case $randomnumber in
				1)
					mplayer /home/pi/Desktop/Sounds_of_La_Queefa/pull.out.mp3 & ;;
				2)
					mplayer /home/pi/Desktop/Sounds_of_La_Queefa/dont.be.scared.mp3 & ;;
				3)
					mplayer /home/pi/Desktop/Sounds_of_La_Queefa/get.in.my.belly.mp3 & ;;
				4)
					mplayer /home/pi/Desktop/Sounds_of_La_Queefa/put.my.pussy.mp3 & ;;
				5)
					mplayer /home/pi/Desktop/Sounds_of_La_Queefa/slime.time.mp3 & ;;
				6)
					mplayer /home/pi/Desktop/Sounds_of_La_Queefa/laqueefa.likes.deep.mp3 & ;;
				7)
					mplayer /home/pi/Desktop/Sounds_of_La_Queefa/oh.wow.mp3 & ;;
				8)
					mplayer /home/pi/Desktop/Sounds_of_La_Queefa/psych.mp3 & ;;
				9)
					mplayer /home/pi/Desktop/Sounds_of_La_Queefa/alisa.pot.stickers.mp3 & ;;
				10)
					mplayer /home/pi/Desktop/Sounds_of_La_Queefa/dave.mammy.lower.mp3 & ;;
				11)
					mplayer /home/pi/Desktop/Sounds_of_La_Queefa/dave.quad.erotic.lower.mp3 & ;;
				12)
					mplayer /home/pi/Desktop/Sounds_of_La_Queefa/jamie.left.right.lower.mp3 & ;;
				13)
					mplayer /home/pi/Desktop/Sounds_of_La_Queefa/lars.dont.mind.mp3 & ;;
				14)
					mplayer /home/pi/Desktop/Sounds_of_La_Queefa/lars.inside.me.mp3 & ;;
				15)
					mplayer /home/pi/Desktop/Sounds_of_La_Queefa/lars.touch.me.mp3 & ;;
				16)
					mplayer /home/pi/Desktop/Sounds_of_La_Queefa/mathias.hotchie.motchie.mp3 & ;;
				17)
					mplayer /home/pi/Desktop/Sounds_of_La_Queefa/patti.to.the.left.lower.mp3 & ;;
				18)
					mplayer /home/pi/Desktop/Sounds_of_La_Queefa/sal.hurry.up.lower.mp3 & ;;
				19)
					mplayer /home/pi/Desktop/Sounds_of_La_Queefa/wrenna.ahh.lower.mp3 & ;;
				20)
					mplayer /home/pi/Desktop/Sounds_of_La_Queefa/wrenna.best.lower.mp3 & ;;
				
			esac
		fi
		
		# 
                # if bcm=6 you get the squirt, else you get a drink
		if [ $bcm = 19 ] 
		then
			echo 1 > /sys/class/gpio/gpio$play/value
			sleep 5		
			echo 0 > /sys/class/gpio/gpio$bcm/value
			sleep 2
			mplayer /home/pi/Desktop/Sounds_of_La_Queefa/sad.trombone.mp3 & 
			echo 0 > /sys/class/gpio/gpio$play/value
			echo 1 > /sys/class/gpio/gpio$bcm/value
        		sleep 0.5 
			echo 0 > /sys/class/gpio/gpio$bcm/value
			sleep 0.2
			echo 1 > /sys/class/gpio/gpio$bcm/value
        		sleep 0.4
			echo 0 > /sys/class/gpio/gpio$bcm/value
			sleep 1.5
        		echo > 1 /sys/class/gpio/gpio$bcm/value
		else				
			sleep 2	
			echo 1 > /sys/class/gpio/gpio$play/value
			echo 0 > /sys/class/gpio/gpio$bcm/value
			sleep 5
			echo 0 > /sys/class/gpio/gpio$play/value
			echo 1 > /sys/class/gpio/gpio$bcm/value
		fi
	else
		echo 1 > /sys/class/gpio/gpio5/value
        	echo 1 > /sys/class/gpio/gpio6/value
        	echo 1 > /sys/class/gpio/gpio13/value
        	echo 1 > /sys/class/gpio/gpio19/value
	

	fi
done

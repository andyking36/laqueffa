#!/bin/bash

#setup drink dispensor, LEDs and input buttons to there associated gpio
button0=12  # laqueefa buttons
button1=16  # "
button2=20  # "
button3=21  # "

button4=14  # buttons on back of laqueffa
button5=15  # "
button6=18  # "
button7=23  # "

bypassSwitch=24   # bypass switch turns off laqueffa buttons

drink0=5    # Relays used for pooring drinks
drink1=6    # "
drink2=13   # "

queefaSquirt=19

ledDisplay0=2
ledDisplay1=3
ledDisplay2=4

# Adjust time needed to poor a drink, in seconds
poorTime=5

# buttons are regularly open so initialize allselections to 0000
allselections=0000

function randomDrink(){
   randomNumber=$((1 + RANDOM % 13))
	echo -e "RANDOM NUMBER IS  $randomNumber\n"
	case $randomNumber in
		1-4)
			drank=$drink0
		   ledDisplay=$ledDisplay0;;
		5-8)
			drank=$drink1
			ledDisplay=$ledDisplay0;;
		9-12)
			drank=$drink2
			ledDisplay=$ledDisplay0;;
		13)
			drank=$queefaSquirt
			ledDisplay=$ledDisplay1;;
      *) 
         drank=$drink0
		   ledDisplay=$ledDisplay0;;
	esac
   
   echo "Drank GPIO: "$drank
   echo "Random Num:" $randomNumber
}

function selectDrink() {
   allselections=$1
   
   case $allselections in
      0001)
            drank=$drink0
			   ledDisplay=$ledDisplay0;;
      0010)
				drank=$drink1
				ledDisplay=$ledDisplay0;;
	   0100)
				drank=$drink2
				ledDisplay=$ledDisplay0;;
		1000)
				drank=$queefaSquirt
				ledDisplay=$ledDisplay1;;
         *) echo "false alarm" 
            main;;
   esac
   echo "Drink GPIO: $drank"
}

function playAudioClip(){
   randomnumber=$((1 + RANDOM % 20))
	echo -e "\nRECORDING NUMBER IS $randomnumber\n"
	case $randomnumber in
		1) mplayer /home/pi/Desktop/Sounds_of_La_Queefa/pull.out.mp3 & ;;
		2) mplayer /home/pi/Desktop/Sounds_of_La_Queefa/dont.be.scared.mp3 & ;;
		3) mplayer /home/pi/Desktop/Sounds_of_La_Queefa/get.in.my.belly.mp3 & ;;
		4) mplayer /home/pi/Desktop/Sounds_of_La_Queefa/put.my.pussy.mp3 & ;;
		5) mplayer /home/pi/Desktop/Sounds_of_La_Queefa/slime.time.mp3 & ;;
		6) mplayer /home/pi/Desktop/Sounds_of_La_Queefa/laqueefa.likes.deep.mp3 & ;;
		7) mplayer /home/pi/Desktop/Sounds_of_La_Queefa/oh.wow.mp3 & ;;
		8) mplayer /home/pi/Desktop/Sounds_of_La_Queefa/psych.mp3 & ;;
		9) mplayer /home/pi/Desktop/Sounds_of_La_Queefa/alisa.pot.stickers.mp3 & ;;
		10) mplayer /home/pi/Desktop/Sounds_of_La_Queefa/dave.mammy.lower.mp3 & ;;
		11) mplayer /home/pi/Desktop/Sounds_of_La_Queefa/dave.quad.erotic.lower.mp3 & ;;
		12) mplayer /home/pi/Desktop/Sounds_of_La_Queefa/jamie.left.right.lower.mp3 & ;;
		13) mplayer /home/pi/Desktop/Sounds_of_La_Queefa/lars.dont.mind.mp3 & ;;
		14) mplayer /home/pi/Desktop/Sounds_of_La_Queefa/lars.inside.me.mp3 & ;;
		15) mplayer /home/pi/Desktop/Sounds_of_La_Queefa/lars.touch.me.mp3 & ;;
		16) mplayer /home/pi/Desktop/Sounds_of_La_Queefa/mathias.hotchie.motchie.mp3 & ;;
		17) mplayer /home/pi/Desktop/Sounds_of_La_Queefa/patti.to.the.left.lower.mp3 & ;;
		18) mplayer /home/pi/Desktop/Sounds_of_La_Queefa/sal.hurry.up.lower.mp3 & ;;
		19) mplayer /home/pi/Desktop/Sounds_of_La_Queefa/wrenna.ahh.lower.mp3 & ;;
		20) mplayer /home/pi/Desktop/Sounds_of_La_Queefa/wrenna.best.lower.mp3 & ;;
		
	esac
}

function poorDrink() {
   drank=$1
   ledDisplay=$2
   sleep 2	
	echo 1 > /sys/class/gpio/gpio$ledDisplay/value
	echo 0 > /sys/class/gpio/gpio$drank/value
	sleep 5
	echo 0 > /sys/class/gpio/gpio$ledDisplay/value
	echo 1 > /sys/class/gpio/gpio$drank/value
}

function activateSquirt() {
   echo 1 > /sys/class/gpio/gpio$ledDisplay/value
	sleep 5		
	echo 0 > /sys/class/gpio/gpio$drank/value
	sleep 2
	#mplayer /home/pi/Desktop/Sounds_of_La_Queefa/sad.trombone.mp3 & 
	echo 0 > /sys/class/gpio/gpio$ledDisplay/value
	echo 1 > /sys/class/gpio/gpio$drank/value
   sleep 0.5 
	echo 0 > /sys/class/gpio/gpio$drank/value
	sleep 0.2
	echo 1 > /sys/class/gpio/gpio$drank/value
   sleep 0.4
	echo 0 > /sys/class/gpio/gpio$drank/value
	sleep 1.5
   echo > 1 /sys/class/gpio/gpio$drank/value
}

function main() {
   allselections=0000
   # loop forever
   while true ; do
   
      if [ $bypass -eq 0 ] ; then
         #wait for laqueefa button drink selection
         while [ $allselections -eq 0000 ] && [ $bypass -eq 0 ]; do
            selection0=$(gpio -g read $button0)
            selection1=$(gpio -g read $button1)
            selection2=$(gpio -g read $button2)
            selection3=$(gpio -g read $button3)
            bypass=$(gpio -g read $bypassSwitch)
            allselections=${selection0}${selection1}${selection2}${selection3}
         done
         # bypass switch was toggled. go to top 
         if [ $bypass -eq 1 ] ; then main; fi
         # a drink button was pressed so select drink to pour
         selectDrink $allselections
         allselections=0000
         # if laqueefa decides to squirt, ledDisplay the sad trumbone song
         if [ $drank -eq $queefaSquirt ] ; then
            activateSquirt
         else
            playAudioClip
            poorDrink $drank $ledDisplay
         fi
      else  
         while [ $allselections -eq 0000 ] && [ $bypass -eq 1 ]; do
            selection0=$(gpio -g read $button4)
            selection1=$(gpio -g read $button5)
            selection2=$(gpio -g read $button6)
            selection3=$(gpio -g read $button7)
            bypass=$(gpio -g read $bypassSwitch)
            allselections=${selection0}${selection1}${selection2}${selection3}
         done
         # bypass switch was toggled. go to top 
         if [ $bypass -eq 0 ] ; then main; fi
         # a drink button was pressed so select drink to pour
         selectDrink $allselections
         allselections=0000
         # if laqueefa decides to squirt, ledDisplay the sad trumbone song
         if [ $drank -eq $queefaSquirt ] ; then
            activateSquirt
         else
            playAudioClip
            poorDrink $drank $ledDisplay
         fi
      fi 

   
   done
   
}
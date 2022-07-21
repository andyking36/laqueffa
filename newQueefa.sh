#!/bin/bash

# Adjust time needed to poor a drink, in seconds
poorTime=5

# buttons are regularly open so initialize allselections to zeros
# number of zeros depends on number of inputs. We are using 8 total.
#
noSelectionsMade=00000000
allselections=$noSelectionsMade

#***********************************************
# Setup drink dispensor, LEDs and input buttons to there associated gpio.
# Input/Output values can be set to whatever gpio you want and will be setup 
# with the function 'setupGPIOs'. The arrays 'gpioInputs' and so on need to 
# be seperated depending on if they are inputs or outputs and what intitial
# output value is desired

#☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺
# inputs
#☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺
ogButtonsInSeries=17 # this is used when all the buttons are in series

button0=12  # laqueefa buttons
button1=16  # "
button2=20  # "
button3=21  # "

button4=14  # buttons on back of laqueffa
button5=15  # "
button6=18  # "
button7=23  # "

remote0=24
remote1=25
remote2=8 
remote3=7 

bypassSwitch=27   # bypass switch turns off laqueffa buttons

#☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺
# outputs
#☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺☺

drink0=5    # relays used for pooring drinks
drink1=6    # "
drink2=13   # "

queefaSquirt=19 # relay used for the ol' squirt party

ledDisplay0=2
ledDisplay1=3
ledDisplay2=4

#♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥
# here are the arrays used to setup
#♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥
gpioPussyInputs="$button0 $button1 $button2 $button3 $ogButtonsInSeries"
gpioBackupPussyInputs="$button4 $button5 $button6 $button7"
gpioRemoteInputs="remote0 remote1 remote2 remote3"

gpioOutputsPumps="$drink0 $drink1 $drink2 $queefaSquirt"
gpioOutputsLed="$ledDisplay0 $ledDisplay1 $ledDisplay2"

# setup gpios for all inputs and outputs
function setupGPIOs() {
   gpioNum=$1
   inOut=$2
   highLow=$3
   for i in $gpioNum; do
      echo $i > /sys/class/gpio/export 
      echo $inOut > /sys/class/gpio/gpio${i}/direction
      if [ "$inOut" == "out" } ; then
         echo $highLow > /sys/class/gpio/gpio${i}/value
      fi
   done
   echo "GPIO Number: "$gpioNum
   echo "In or Out: "$inOut
   echo "High or Low: "$highLow
}

setupGPIOs $gpioInputs "in" 
setupGPIOs $gpioBackupPussyInputs "in"
setupGPIOs $gpioRemoteInputs "in"
setupGPIOs $gpioOutputsPumps "out" 1
setupGPIOs $gpioOutputsLed "out" 0
#***********************************************

# this was used when all pussy buttons were in series so all 
# buttons were ited to one input
function randomDrink(){
   echo "randomDrink"
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
   echo "selectDrink: $allselections"
   case $allselections in
      # remote selections 
      00000001)
            drank=$drink0
			   ledDisplay=$ledDisplay0;;
      00000010)
				drank=$drink1
				ledDisplay=$ledDisplay0;;
	   00000100)
				drank=$drink2
				ledDisplay=$ledDisplay0;;
		00001000)
				drank=$queefaSquirt
				ledDisplay=$ledDisplay1;;
      # pussy button selections
      00010000)
            drank=$drink0
			   ledDisplay=$ledDisplay0;;
      00100000)
				drank=$drink1
				ledDisplay=$ledDisplay0;;
	   01000000)
				drank=$drink2
				ledDisplay=$ledDisplay0;;
		10000000)
				drank=$queefaSquirt
				ledDisplay=$ledDisplay1;;
         *) echo "false alarm" 
            main;;
   esac
   echo "Drink GPIO: $drank"
}

function playAudioClip(){
   echo "playAudioClip"
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
   echo "poorDrink: $drank $ledDisplay"
   sleep 2	
	echo 1 > /sys/class/gpio/gpio$ledDisplay/value
	echo 0 > /sys/class/gpio/gpio$drank/value
	sleep 5
	echo 0 > /sys/class/gpio/gpio$ledDisplay/value
	echo 1 > /sys/class/gpio/gpio$drank/value
}

function activateSquirt() {
  echo "squirt time"
   echo 1 > /sys/class/gpio/gpio$ledDisplay/value
	sleep 5		
	echo 0 > /sys/class/gpio/gpio$drank/value
	sleep 2
	mplayer /home/pi/Desktop/Sounds_of_La_Queefa/sad.trombone.mp3 & 
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

function waitForPussyPlay() {
  echo "waitForPussyPlay"
   allselections=$noSelectionsMade
   bypass=$(gpio -g read $bypassSwitch)
   # loop forever
   while true ; do
   
      if [ $bypass -eq 0 ] ; then
         #wait for laqueefa's pussy buttons, bypass toggle or remote control
         while [ $allselections -eq $noSelectionsMade ] && [ $bypass -eq 0 ]; do
            s0=$(gpio -g read $button0)
            s1=$(gpio -g read $button1)
            s2=$(gpio -g read $button2)
            s3=$(gpio -g read $button3)
            s4=$(gpio -g read $remote0)
            s5=$(gpio -g read $remote1)
            s6=$(gpio -g read $remote2)
            s7=$(gpio -g read $remote3)
            bypass=$(gpio -g read $bypassSwitch)
            allselections=${s0}${s1}${s2}${s3}${s4}${s5}${s6}${s7}
            echo "T0 allselections: $allselections bypass $bypass"
         done
         # if bypass switch was toggled go back to main 
         if [ $bypass -eq 1 ] ; then main; fi
         # if not a drink button was pressed so select drink to pour
         selectDrink $allselections
         allselections=$noSelectionsMade
         # if laqueefa decides to squirt, ledDisplay the sad trumbone song
         if [ $drank -eq $queefaSquirt ] ; then
            activateSquirt
         else
            playAudioClip
            poorDrink $drank $ledDisplay
         fi
      else  
         #wait for rear buttons, bypass toggle or remote control
         while [ $allselections -eq $noSelectionsMade ] && [ $bypass -eq 1 ]; do
            s0=$(gpio -g read $button4)
            s1=$(gpio -g read $button5)
            s2=$(gpio -g read $button6)
            s3=$(gpio -g read $button7)
            s4=$(gpio -g read $remote0)
            s5=$(gpio -g read $remote1)
            s6=$(gpio -g read $remote2)
            s7=$(gpio -g read $remote3)
            bypass=$(gpio -g read $bypassSwitch)
            allselections=${s0}${s1}${s2}${s3}${s4}${s5}${s6}${s7}
            echo "T1 allselections: $allselections bypass $bypass"
         done
         # bypass switch was toggled. go to top 
         #if [ $bypass -eq 0 ] ; then main; fi
         # a drink button was pressed so select drink to pour
         selectDrink $allselections
         allselections=$noSelectionsMade
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

function main() {

   while true ; do
      waitForPussyPlay
   done
   
}

#start program from main
main